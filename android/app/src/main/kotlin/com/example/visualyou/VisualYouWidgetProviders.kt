package com.example.visualyou

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.graphics.Color
import android.net.Uri
import android.text.SpannableStringBuilder
import android.text.Spanned
import android.text.style.ForegroundColorSpan
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
                val planId = widgetData.getString("reduction_plan_id", null)
                val habitName = widgetData.getString("reduction_habit_name", null)
                val mode = widgetData.getString("reduction_mode", null)
                setTextViewText(R.id.reduction_name, if (habitName == null) "Create a plan in the app" else "$habitName • ${mode.orEmpty().replaceFirstChar { it.uppercase() }}")
                setTextColor(R.id.reduction_name, accentColor(widgetData))
                setTextViewText(R.id.reduction_status, if (widgetData.getBoolean("reduction_tracked_today", false)) "Today is tracked ✓" else "Today is not tracked")
                val calendar = Calendar.getInstance()
                val firstDay = (calendar.clone() as Calendar).apply { set(Calendar.DAY_OF_MONTH, 1) }
                val levels = widgetData.getString("reduction_levels", "").orEmpty().split(',').mapNotNull { it.toIntOrNull() }
                setTextViewText(
                    R.id.reduction_grid,
                    buildCalendarGrid(
                        calendar.getActualMaximum(Calendar.DAY_OF_MONTH),
                        ((firstDay.get(Calendar.DAY_OF_WEEK) + 5) % 7) + 1,
                    ) { day ->
                        when (levels.getOrNull(day - 1)) {
                            0 -> Color.rgb(150, 170, 210)
                            1 -> Color.rgb(98, 125, 205)
                            2 -> Color.rgb(70, 95, 170)
                            3 -> Color.rgb(230, 72, 72)
                            4 -> Color.rgb(70, 180, 112)
                            else -> Color.rgb(145, 151, 164)
                        }
                    },
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
        val grid = buildCalendarGrid(days, firstWeekday) { day ->
            when (levels.getOrNull(day - 1)) {
                0 -> Color.rgb(230, 72, 72)
                1 -> Color.rgb(244, 139, 44)
                2 -> Color.rgb(222, 190, 45)
                3 -> Color.rgb(71, 174, 104)
                4 -> Color.rgb(66, 133, 235)
                else -> Color.rgb(145, 151, 164)
            }
        }
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_month_calendar).apply {
                setTextColor(R.id.calendar_title, accentColor(widgetData))
                setTextViewText(R.id.calendar_month, monthName(year, month))
                setTextViewText(R.id.calendar_grid, grid)
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
        val joined = Calendar.getInstance().apply {
            set(widgetData.getInt("streak_joined_year", year), widgetData.getInt("streak_joined_month", month) - 1, widgetData.getInt("streak_joined_day", 1), 0, 0, 0)
            set(Calendar.MILLISECOND, 0)
        }
        val grid = buildCalendarGrid(days, firstWeekday) { day ->
            val cell = Calendar.getInstance().apply { set(year, month - 1, day, 0, 0, 0); set(Calendar.MILLISECOND, 0) }
            when {
                activeDays.contains(day) -> Color.rgb(255, 138, 36)
                !cell.after(now) && !cell.before(joined) -> Color.rgb(139, 211, 244)
                else -> Color.rgb(145, 151, 164)
            }
        }
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_streak_calendar).apply {
                setTextViewText(R.id.streak_count, "🔥 ${widgetData.getInt("streak_current", 0)}")
                setTextViewText(R.id.streak_month, monthName(year, month))
                setTextViewText(R.id.streak_grid, grid)
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

private fun buildCalendarGrid(days: Int, firstWeekday: Int, colorForDay: (Int) -> Int): CharSequence {
    val result = SpannableStringBuilder("Mo Tu We Th Fr Sa Su\n")
    repeat(firstWeekday - 1) { result.append("   ") }
    for (day in 1..days) {
        val start = result.length
        result.append(String.format(Locale.ROOT, "%2d", day))
        result.setSpan(ForegroundColorSpan(colorForDay(day)), start, result.length, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE)
        val column = (firstWeekday - 1 + day - 1) % 7
        if (column == 6) result.append('\n') else result.append(' ')
    }
    return result
}
