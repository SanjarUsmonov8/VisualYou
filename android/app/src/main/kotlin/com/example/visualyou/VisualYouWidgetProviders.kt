package com.example.visualyou

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.content.res.Configuration
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.RectF
import android.graphics.Typeface
import android.net.Uri
import android.view.View
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Locale

private fun openIntent(context: Context, target: String): PendingIntent =
    HomeWidgetLaunchIntent.getActivity(
        context,
        MainActivity::class.java,
        Uri.parse("visualyou://open/$target"),
    )

private fun actionIntent(
    context: Context,
    action: String,
    idName: String,
    id: String,
    didHabit: Boolean,
): PendingIntent = HomeWidgetBackgroundIntent.getBroadcast(
    context,
    Uri.Builder()
        .scheme("visualyou")
        .authority("action")
        .appendPath(action)
        .appendQueryParameter(idName, id)
        .appendQueryParameter("didHabit", didHabit.toString())
        .build(),
)

private fun accentColor(data: SharedPreferences): Int =
    if (data.getString("widget_accent", "blue") == "pink") Color.rgb(220, 76, 139)
    else Color.rgb(82, 109, 255)

private fun isWidgetDark(context: Context, data: SharedPreferences): Boolean =
    when (data.getString("widget_theme_mode", "system")) {
        "dark" -> true
        "light" -> false
        else -> context.resources.configuration.uiMode and Configuration.UI_MODE_NIGHT_MASK ==
            Configuration.UI_MODE_NIGHT_YES
    }

private fun widgetBackground(context: Context, data: SharedPreferences): Int =
    if (isWidgetDark(context, data)) R.drawable.widget_background_dark
    else R.drawable.widget_background_light

private fun widgetTextColor(context: Context, data: SharedPreferences): Int =
    if (isWidgetDark(context, data)) Color.rgb(244, 246, 250)
    else Color.rgb(23, 32, 51)

private fun widgetMutedColor(context: Context, data: SharedPreferences): Int =
    if (isWidgetDark(context, data)) Color.rgb(185, 192, 206)
    else Color.rgb(101, 112, 135)

private fun RemoteViews.bindHabit(
    context: Context,
    data: SharedPreferences,
    index: Int,
    rowId: Int,
    nameId: Int,
    firstActionId: Int,
    secondActionId: Int,
    freeTarget: String,
) {
    val habitId = data.getString("quick_${index}_id", null)
    val name = data.getString("quick_${index}_name", null)
    if (habitId == null || name == null) {
        setViewVisibility(rowId, View.GONE)
        return
    }
    setViewVisibility(rowId, View.VISIBLE)
    setTextViewText(nameId, name)
    setTextColor(nameId, accentColor(data))
    setOnClickPendingIntent(nameId, openIntent(context, freeTarget))
    val unwanted = data.getBoolean("quick_${index}_unwanted", false)
    setTextViewText(firstActionId, if (unwanted) "👎" else "👍")
    setTextViewText(secondActionId, if (unwanted) "👍" else "👎")
    if (data.getBoolean("is_plus", false)) {
        setOnClickPendingIntent(
            firstActionId,
            actionIntent(context, "habit", "habitId", habitId, !unwanted),
        )
        setOnClickPendingIntent(
            secondActionId,
            actionIntent(context, "habit", "habitId", habitId, unwanted),
        )
    } else {
        val launch = openIntent(context, freeTarget)
        setOnClickPendingIntent(firstActionId, launch)
        setOnClickPendingIntent(secondActionId, launch)
    }
}

class QuickAddWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences,
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_quick_add).apply {
                setTextColor(R.id.widget_title, accentColor(widgetData))
                setOnClickPendingIntent(R.id.widget_root, openIntent(context, "quick-add"))
                setTextViewText(
                    R.id.widget_subtitle,
                    if (widgetData.getBoolean("is_plus", false)) "Visual You Plus" else "Tap to open Visual You",
                )
                bindHabit(context, widgetData, 0, R.id.quick_row_0, R.id.quick_name_0, R.id.quick_positive_0, R.id.quick_negative_0, "quick-add")
                bindHabit(context, widgetData, 1, R.id.quick_row_1, R.id.quick_name_1, R.id.quick_positive_1, R.id.quick_negative_1, "quick-add")
                bindHabit(context, widgetData, 2, R.id.quick_row_2, R.id.quick_name_2, R.id.quick_positive_2, R.id.quick_negative_2, "quick-add")
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}

class SingleHabitWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_single_habit).apply {
                val habitId = widgetData.getString("single_id", null)
                val name = widgetData.getString("single_name", null) ?: "Choose a Quick Add favorite"
                val unwanted = widgetData.getBoolean("single_unwanted", false)
                setTextViewText(R.id.single_name, name)
                setTextColor(R.id.single_name, accentColor(widgetData))
                setTextViewText(R.id.single_positive, if (unwanted) "👎" else "👍")
                setTextViewText(R.id.single_negative, if (unwanted) "👍" else "👎")
                setOnClickPendingIntent(R.id.widget_root, openIntent(context, "single-habit"))
                if (habitId != null && widgetData.getBoolean("is_plus", false)) {
                    setOnClickPendingIntent(R.id.single_positive, actionIntent(context, "habit", "habitId", habitId, !unwanted))
                    setOnClickPendingIntent(R.id.single_negative, actionIntent(context, "habit", "habitId", habitId, unwanted))
                } else {
                    val launch = openIntent(context, "single-habit")
                    setOnClickPendingIntent(R.id.single_positive, launch)
                    setOnClickPendingIntent(R.id.single_negative, launch)
                }
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}

class ReductionCalendarWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_reduction_calendar).apply {
                setInt(R.id.widget_root, "setBackgroundResource", widgetBackground(context, widgetData))
                val planId = widgetData.getString("reduction_plan_id", null)
                val habitName = widgetData.getString("reduction_habit_name", null)
                val mode = widgetData.getString("reduction_mode", null)
                setTextColor(R.id.reduction_title, widgetTextColor(context, widgetData))
                setTextViewText(R.id.reduction_name, if (habitName == null) "Create a plan in the app" else "$habitName • ${mode.orEmpty().replaceFirstChar { it.uppercase() }}")
                setTextColor(R.id.reduction_name, accentColor(widgetData))
                setTextColor(R.id.reduction_month, widgetTextColor(context, widgetData))
                setTextColor(R.id.reduction_status, widgetMutedColor(context, widgetData))
                setTextViewText(R.id.reduction_status, if (widgetData.getBoolean("reduction_tracked_today", false)) "Today is tracked ✓" else "Today is not tracked")
                val calendar = Calendar.getInstance()
                val firstDay = (calendar.clone() as Calendar).apply { set(Calendar.DAY_OF_MONTH, 1) }
                val levels = widgetData.getString("reduction_levels", "").orEmpty().split(',').mapNotNull { it.toIntOrNull() }
                setTextViewText(
                    R.id.reduction_month,
                    monthName(
                        calendar.get(Calendar.YEAR),
                        calendar.get(Calendar.MONTH) + 1,
                    ),
                )
                setImageViewBitmap(
                    R.id.reduction_grid,
                    renderCalendar(
                        context = context,
                        days = calendar.getActualMaximum(Calendar.DAY_OF_MONTH),
                        firstWeekday = ((firstDay.get(Calendar.DAY_OF_WEEK) + 5) % 7) + 1,
                        kind = CalendarKind.REDUCTION,
                        accent = accentColor(widgetData),
                        dark = isWidgetDark(context, widgetData),
                        levelForDay = { day -> levels.getOrNull(day - 1) ?: -1 },
                    ),
                )
                setOnClickPendingIntent(R.id.widget_root, openIntent(context, "reduction"))
                if (planId != null && widgetData.getBoolean("is_plus", false)) {
                    setOnClickPendingIntent(R.id.reduction_avoided, actionIntent(context, "reduction", "planId", planId, false))
                    setOnClickPendingIntent(R.id.reduction_did, actionIntent(context, "reduction", "planId", planId, true))
                } else {
                    val launch = openIntent(context, "reduction")
                    setOnClickPendingIntent(R.id.reduction_avoided, launch)
                    setOnClickPendingIntent(R.id.reduction_did, launch)
                }
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}

class MainCalendarWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
        val year = widgetData.getInt("calendar_year", Calendar.getInstance().get(Calendar.YEAR))
        val month = widgetData.getInt("calendar_month", Calendar.getInstance().get(Calendar.MONTH) + 1)
        val days = widgetData.getInt("calendar_days_in_month", 31)
        val firstWeekday = widgetData.getInt("calendar_first_weekday", 1)
        val levels = widgetData.getString("calendar_levels", "")!!.split(',').mapNotNull { it.toIntOrNull() }
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_month_calendar).apply {
                setInt(R.id.widget_root, "setBackgroundResource", widgetBackground(context, widgetData))
                setTextColor(R.id.calendar_title, accentColor(widgetData))
                setTextColor(R.id.calendar_month, widgetTextColor(context, widgetData))
                setTextViewText(R.id.calendar_month, monthName(year, month))
                setImageViewBitmap(
                    R.id.calendar_grid,
                    renderCalendar(
                        context = context,
                        days = days,
                        firstWeekday = firstWeekday,
                        kind = CalendarKind.PERFORMANCE,
                        accent = accentColor(widgetData),
                        dark = isWidgetDark(context, widgetData),
                        levelForDay = { day -> levels.getOrNull(day - 1) ?: 99 },
                    ),
                )
                setOnClickPendingIntent(R.id.widget_root, openIntent(context, "calendar"))
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}

class StreakCalendarWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
        val now = Calendar.getInstance()
        val year = widgetData.getInt("calendar_year", now.get(Calendar.YEAR))
        val month = widgetData.getInt("calendar_month", now.get(Calendar.MONTH) + 1)
        val days = widgetData.getInt("calendar_days_in_month", 31)
        val firstWeekday = widgetData.getInt("calendar_first_weekday", 1)
        val activeDays = widgetData.getString("streak_activity_days", "").orEmpty().split(',').mapNotNull { it.toIntOrNull() }.toSet()
        val protectedDays = widgetData.getString("streak_protected_days", "").orEmpty().split(',').mapNotNull { it.toIntOrNull() }.toSet()
        val joined = Calendar.getInstance().apply {
            set(widgetData.getInt("streak_joined_year", year), widgetData.getInt("streak_joined_month", month) - 1, widgetData.getInt("streak_joined_day", 1), 0, 0, 0)
            set(Calendar.MILLISECOND, 0)
        }
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_streak_calendar).apply {
                setInt(R.id.widget_root, "setBackgroundResource", widgetBackground(context, widgetData))
                setTextColor(R.id.streak_title, widgetTextColor(context, widgetData))
                setTextViewText(R.id.streak_count, "🔥 ${widgetData.getInt("streak_current", 0)}")
                setTextViewText(R.id.streak_month, monthName(year, month))
                setTextColor(R.id.streak_month, widgetTextColor(context, widgetData))
                setImageViewBitmap(
                    R.id.streak_grid,
                    renderCalendar(
                        context = context,
                        days = days,
                        firstWeekday = firstWeekday,
                        kind = CalendarKind.STREAK,
                        accent = accentColor(widgetData),
                        dark = isWidgetDark(context, widgetData),
                        levelForDay = { day ->
                            val cell = Calendar.getInstance().apply {
                                set(year, month - 1, day, 0, 0, 0)
                                set(Calendar.MILLISECOND, 0)
                            }
                            when {
                                activeDays.contains(day) -> 1
                                protectedDays.contains(day) && cell.before(now) -> 2
                                !cell.after(now) && !cell.before(joined) -> 0
                                else -> -1
                            }
                        },
                    ),
                )
                setOnClickPendingIntent(R.id.widget_root, openIntent(context, "streak"))
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}

private fun monthName(year: Int, month: Int): String {
    val calendar = Calendar.getInstance().apply { set(year, month - 1, 1) }
    return SimpleDateFormat("MMMM yyyy", Locale.getDefault()).format(calendar.time)
}

private enum class CalendarKind { PERFORMANCE, REDUCTION, STREAK }

private fun renderCalendar(
    context: Context,
    days: Int,
    firstWeekday: Int,
    kind: CalendarKind,
    accent: Int,
    dark: Boolean,
    levelForDay: (Int) -> Int,
): Bitmap {
    val columns = 7
    val cellWidth = 70f
    val headerHeight = 38f
    val cellHeight = 62f
    val usedCells = firstWeekday - 1 + days
    val rows = if (usedCells <= 35) 5 else 6
    val width = (columns * cellWidth).toInt()
    val height = (headerHeight + rows * cellHeight).toInt()
    val bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
    val canvas = Canvas(bitmap)
    val textColor = if (dark) Color.rgb(244, 246, 250) else Color.rgb(23, 32, 51)
    val mutedColor = if (dark) Color.rgb(185, 192, 206) else Color.rgb(101, 112, 135)
    val surfaceColor = if (dark) Color.rgb(36, 39, 46) else Color.rgb(240, 242, 245)
    val softColor = if (dark) Color.rgb(52, 58, 71) else Color.rgb(225, 229, 234)
    val mildAccent = blendColors(accent, surfaceColor, .24f)
    val trackAccent = blendColors(accent, surfaceColor, .38f)
    val dayPaint = Paint(Paint.ANTI_ALIAS_FLAG).apply { style = Paint.Style.FILL }
    val textPaint = Paint(Paint.ANTI_ALIAS_FLAG).apply {
        color = textColor
        textAlign = Paint.Align.CENTER
        textSize = 22f
        typeface = Typeface.create(Typeface.DEFAULT, Typeface.BOLD)
    }
    val weekdayPaint = Paint(textPaint).apply {
        color = mutedColor
        textSize = 18f
    }

    localizedWeekdays().forEachIndexed { index, label ->
        drawCenteredText(
            canvas,
            label,
            (index + .5f) * cellWidth,
            headerHeight / 2f,
            weekdayPaint,
        )
    }

    fun center(day: Int): Pair<Float, Float> {
        val index = firstWeekday - 1 + day - 1
        return Pair(
            (index % columns + .5f) * cellWidth,
            headerHeight + (index / columns + .5f) * cellHeight,
        )
    }

    fun isConnected(day: Int): Boolean {
        if (day !in 1..days) return false
        return when (kind) {
            CalendarKind.REDUCTION ->
                levelForDay(day) != -1 &&
                    levelForDay(day) != 3 &&
                    day <= Calendar.getInstance().get(Calendar.DAY_OF_MONTH)
            CalendarKind.STREAK -> levelForDay(day) == 1 || levelForDay(day) == 2
            CalendarKind.PERFORMANCE -> false
        }
    }

    val diameter = 48f
    if (kind != CalendarKind.PERFORMANCE) {
        val connectionPaint = Paint(Paint.ANTI_ALIAS_FLAG).apply {
            color = if (kind == CalendarKind.STREAK) {
                Color.rgb(255, 138, 36)
            } else {
                trackAccent
            }
            strokeWidth = diameter
            strokeCap = Paint.Cap.BUTT
        }
        for (day in 1..days) {
            if (!isConnected(day)) continue
            val index = firstWeekday - 1 + day - 1
            val column = index % columns
            val (x, y) = center(day)
            if (column > 0 && isConnected(day - 1)) {
                val (previousX, previousY) = center(day - 1)
                canvas.drawLine(previousX, previousY, x, y, connectionPaint)
            }
            if (kind == CalendarKind.REDUCTION && column == 0 && isConnected(day - 1)) {
                canvas.drawLine(0f, y, x, y, connectionPaint)
            }
            if (kind == CalendarKind.REDUCTION && column == 6 && isConnected(day + 1)) {
                canvas.drawLine(x, y, width.toFloat(), y, connectionPaint)
            }
        }
    }

    for (day in 1..days) {
        val level = levelForDay(day)
        val (x, y) = center(day)
        var foreground = textColor
        dayPaint.color = when (kind) {
            CalendarKind.PERFORMANCE -> when (level) {
                0 -> Color.rgb(230, 72, 72)
                1 -> Color.rgb(244, 139, 44)
                2 -> Color.rgb(222, 190, 45)
                3 -> Color.rgb(71, 174, 104)
                4 -> Color.rgb(66, 133, 235)
                else -> softColor
            }
            CalendarKind.REDUCTION -> when (level) {
                1, 2 -> accent
                3 -> Color.rgb(229, 57, 53)
                0, 4 -> mildAccent
                else -> softColor
            }
            CalendarKind.STREAK -> when (level) {
                1 -> Color.rgb(255, 138, 36)
                0, 2 -> Color.rgb(191, 234, 255)
                else -> softColor
            }
        }
        if (
            (kind == CalendarKind.PERFORMANCE && level in 0..4) ||
                (kind == CalendarKind.REDUCTION && level in 1..3) ||
                (kind == CalendarKind.STREAK && level == 1)
        ) {
            foreground = Color.WHITE
        } else if (kind == CalendarKind.STREAK && level == 0) {
            foreground = Color.rgb(36, 90, 115)
        }

        if (kind == CalendarKind.PERFORMANCE) {
            canvas.drawRoundRect(
                RectF(x - 25f, y - 25f, x + 25f, y + 25f),
                16f,
                16f,
                dayPaint,
            )
        } else {
            canvas.drawCircle(x, y, diameter / 2f, dayPaint)
        }

        if (kind == CalendarKind.REDUCTION && (level == 2 || level == 4)) {
            drawCheck(canvas, x, y, foreground)
        } else {
            textPaint.color = foreground
            drawCenteredText(canvas, day.toString(), x, y, textPaint)
        }
    }
    return bitmap
}

private fun localizedWeekdays(): List<String> {
    val weekdays = java.text.DateFormatSymbols.getInstance().shortWeekdays
    return listOf(2, 3, 4, 5, 6, 7, 1).map { index ->
        weekdays[index].take(1).uppercase(Locale.getDefault())
    }
}

private fun drawCenteredText(canvas: Canvas, text: String, x: Float, y: Float, paint: Paint) {
    val metrics = paint.fontMetrics
    canvas.drawText(text, x, y - (metrics.ascent + metrics.descent) / 2f, paint)
}

private fun drawCheck(canvas: Canvas, x: Float, y: Float, color: Int) {
    val paint = Paint(Paint.ANTI_ALIAS_FLAG).apply {
        this.color = color
        style = Paint.Style.STROKE
        strokeWidth = 5f
        strokeCap = Paint.Cap.ROUND
        strokeJoin = Paint.Join.ROUND
    }
    canvas.drawLine(x - 10f, y, x - 3f, y + 7f, paint)
    canvas.drawLine(x - 3f, y + 7f, x + 11f, y - 9f, paint)
}

private fun blendColors(foreground: Int, background: Int, amount: Float): Int {
    fun channel(start: Int, end: Int): Int =
        (start * amount + end * (1f - amount)).toInt()
    return Color.rgb(
        channel(Color.red(foreground), Color.red(background)),
        channel(Color.green(foreground), Color.green(background)),
        channel(Color.blue(foreground), Color.blue(background)),
    )
}
