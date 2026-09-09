import 'package:flutter/material.dart';

class AppStrings {
  const AppStrings(this.locale);

  final Locale locale;

  static const supportedLocales = [
    Locale('en'),
    Locale('es'),
    Locale('ru'),
    Locale('fr'),
    Locale('uz'),
  ];

  static AppStrings of(BuildContext context) {
    return Localizations.of<AppStrings>(context, AppStrings) ??
        AppStrings(Localizations.localeOf(context));
  }

  String text(String key) {
    return _deviceTransferTranslations[locale.languageCode]?[key] ??
        _deviceTransferTranslations['en']?[key] ??
        _numericalHeatmapTranslations[locale.languageCode]?[key] ??
        _habitStreakTranslations[locale.languageCode]?[key] ??
        _measurementTranslations[locale.languageCode]?[key] ??
        _growthTranslations[locale.languageCode]?[key] ??
        _bodyMuscleTranslations[locale.languageCode]?[key] ??
        _organReportTranslations[locale.languageCode]?[key] ??
        _singleGraphTranslations[locale.languageCode]?[key] ??
        _namedGraphTranslations[locale.languageCode]?[key] ??
        _numericalTranslations[locale.languageCode]?[key] ??
        _authTranslations[locale.languageCode]?[key] ??
        _onboardingTranslations[locale.languageCode]?[key] ??
        _adTranslations[locale.languageCode]?[key] ??
        _newFeatureTranslations[locale.languageCode]?[key] ??
        _rewardTranslations[locale.languageCode]?[key] ??
        _translations[locale.languageCode]?[key] ??
        _translations['en']![key] ??
        key;
  }

  String added(String habit) {
    return switch (locale.languageCode) {
      'es' => 'Se añadió $habit',
      'ru' => 'Добавлено: $habit',
      'fr' => '$habit ajouté',
      'uz' => '$habit qo‘shildi',
      _ => '$habit added',
    };
  }

  static const delegate = _AppStringsDelegate();
}

const Map<String, Map<String, String>> _deviceTransferTranslations = {
  'en': {
    'Device transfer': 'Device transfer',
    'Back up for 10 days for changing device':
        'Back up for 10 days for changing device',
    'Your backup is being prepared and uploaded.':
        'Your backup is being prepared and uploaded.',
    'Temporarily save your filled habits, plans, calendars, graphs, and settings for your new phone.':
        'Temporarily save your filled habits, plans, calendars, graphs, and settings for your new phone.',
    'Create a 10-day backup?': 'Create a 10-day backup?',
    'Your current temporary backup will be replaced. The new backup automatically expires after 10 days.':
        'Your current temporary backup will be replaced. The new backup automatically expires after 10 days.',
    'Back up': 'Back up',
    'Your 10-day backup is ready.': 'Your 10-day backup is ready.',
    'The backup could not be completed.': 'The backup could not be completed.',
    'Preparing your backup': 'Preparing your backup',
    'Uploading your backup': 'Uploading your backup',
    'Backup ready for device transfer': 'Backup ready for device transfer',
    'Get your data on this device': 'Get your data on this device',
    'Downloading your data': 'Downloading your data',
    'Restoring your data': 'Restoring your data',
    'Your data is restored': 'Your data is restored',
    'Backup needs attention': 'Backup needs attention',
    'Restore': 'Restore',
    'Available until': 'Available until',
    'Try again from Settings.': 'Try again from Settings.',
    'Restore backup?': 'Restore backup?',
    'This replaces the habit data currently stored on this phone with your saved backup.':
        'This replaces the habit data currently stored on this phone with your saved backup.',
    'Sign in before creating a backup.': 'Sign in before creating a backup.',
    'Sign in before restoring a backup.': 'Sign in before restoring a backup.',
    'The device-transfer backup could not be completed.':
        'The device-transfer backup could not be completed.',
  },
  'es': {
    'Device transfer': 'Transferencia de dispositivo',
    'Back up for 10 days for changing device':
        'Copia de seguridad de 10 días para cambiar de dispositivo',
    'Your backup is being prepared and uploaded.':
        'Tu copia se está preparando y subiendo.',
    'Temporarily save your filled habits, plans, calendars, graphs, and settings for your new phone.':
        'Guarda temporalmente tus hábitos, planes, calendarios, gráficos y ajustes para tu nuevo teléfono.',
    'Create a 10-day backup?': '¿Crear una copia de 10 días?',
    'Your current temporary backup will be replaced. The new backup automatically expires after 10 days.':
        'Tu copia temporal actual será reemplazada. La nueva caduca automáticamente después de 10 días.',
    'Back up': 'Crear copia',
    'Your 10-day backup is ready.': 'Tu copia de 10 días está lista.',
    'The backup could not be completed.': 'No se pudo completar la copia.',
    'Preparing your backup': 'Preparando tu copia',
    'Uploading your backup': 'Subiendo tu copia',
    'Backup ready for device transfer': 'Copia lista para transferir',
    'Get your data on this device': 'Obtén tus datos en este dispositivo',
    'Downloading your data': 'Descargando tus datos',
    'Restoring your data': 'Restaurando tus datos',
    'Your data is restored': 'Tus datos se restauraron',
    'Backup needs attention': 'La copia necesita atención',
    'Restore': 'Restaurar',
    'Available until': 'Disponible hasta',
    'Try again from Settings.': 'Inténtalo de nuevo desde Ajustes.',
    'Restore backup?': '¿Restaurar la copia?',
    'This replaces the habit data currently stored on this phone with your saved backup.':
        'Esto reemplaza los datos de hábitos de este teléfono con tu copia guardada.',
  },
  'ru': {
    'Device transfer': 'Перенос на устройство',
    'Back up for 10 days for changing device':
        'Резервная копия на 10 дней для смены устройства',
    'Your backup is being prepared and uploaded.':
        'Резервная копия подготавливается и загружается.',
    'Temporarily save your filled habits, plans, calendars, graphs, and settings for your new phone.':
        'Временно сохраните привычки, планы, календари, графики и настройки для нового телефона.',
    'Create a 10-day backup?': 'Создать резервную копию на 10 дней?',
    'Your current temporary backup will be replaced. The new backup automatically expires after 10 days.':
        'Текущая временная копия будет заменена. Новая автоматически удалится через 10 дней.',
    'Back up': 'Создать копию',
    'Your 10-day backup is ready.': 'Резервная копия на 10 дней готова.',
    'The backup could not be completed.': 'Не удалось создать резервную копию.',
    'Preparing your backup': 'Подготовка резервной копии',
    'Uploading your backup': 'Загрузка резервной копии',
    'Backup ready for device transfer': 'Копия готова для переноса',
    'Get your data on this device': 'Получить данные на этом устройстве',
    'Downloading your data': 'Загрузка ваших данных',
    'Restoring your data': 'Восстановление данных',
    'Your data is restored': 'Ваши данные восстановлены',
    'Backup needs attention': 'Требуется проверить копию',
    'Restore': 'Восстановить',
    'Available until': 'Доступно до',
    'Try again from Settings.': 'Повторите попытку в настройках.',
    'Restore backup?': 'Восстановить резервную копию?',
    'This replaces the habit data currently stored on this phone with your saved backup.':
        'Данные привычек на этом телефоне будут заменены сохранённой копией.',
  },
  'fr': {
    'Device transfer': 'Transfert d’appareil',
    'Back up for 10 days for changing device':
        'Sauvegarde de 10 jours pour changer d’appareil',
    'Your backup is being prepared and uploaded.':
        'Votre sauvegarde est en préparation et en cours d’envoi.',
    'Temporarily save your filled habits, plans, calendars, graphs, and settings for your new phone.':
        'Enregistrez temporairement vos habitudes, plans, calendriers, graphiques et réglages pour votre nouveau téléphone.',
    'Create a 10-day backup?': 'Créer une sauvegarde de 10 jours ?',
    'Your current temporary backup will be replaced. The new backup automatically expires after 10 days.':
        'Votre sauvegarde temporaire actuelle sera remplacée. La nouvelle expirera automatiquement après 10 jours.',
    'Back up': 'Sauvegarder',
    'Your 10-day backup is ready.': 'Votre sauvegarde de 10 jours est prête.',
    'The backup could not be completed.': 'La sauvegarde n’a pas pu être terminée.',
    'Preparing your backup': 'Préparation de votre sauvegarde',
    'Uploading your backup': 'Envoi de votre sauvegarde',
    'Backup ready for device transfer': 'Sauvegarde prête pour le transfert',
    'Get your data on this device': 'Récupérer vos données sur cet appareil',
    'Downloading your data': 'Téléchargement de vos données',
    'Restoring your data': 'Restauration de vos données',
    'Your data is restored': 'Vos données sont restaurées',
    'Backup needs attention': 'La sauvegarde nécessite votre attention',
    'Restore': 'Restaurer',
    'Available until': 'Disponible jusqu’au',
    'Try again from Settings.': 'Réessayez depuis les réglages.',
    'Restore backup?': 'Restaurer la sauvegarde ?',
    'This replaces the habit data currently stored on this phone with your saved backup.':
        'Cela remplace les données d’habitudes de ce téléphone par votre sauvegarde.',
  },
  'uz': {
    'Device transfer': 'Qurilmani almashtirish',
    'Back up for 10 days for changing device':
        'Qurilmani almashtirish uchun 10 kunlik nusxa',
    'Your backup is being prepared and uploaded.':
        'Nusxangiz tayyorlanmoqda va yuklanmoqda.',
    'Temporarily save your filled habits, plans, calendars, graphs, and settings for your new phone.':
        'Yangi telefon uchun odatlar, rejalar, kalendarlar, grafiklar va sozlamalarni vaqtincha saqlang.',
    'Create a 10-day backup?': '10 kunlik nusxa yaratilsinmi?',
    'Your current temporary backup will be replaced. The new backup automatically expires after 10 days.':
        'Joriy vaqtinchalik nusxa almashtiriladi. Yangi nusxa 10 kundan keyin avtomatik o‘chadi.',
    'Back up': 'Nusxa yaratish',
    'Your 10-day backup is ready.': '10 kunlik nusxangiz tayyor.',
    'The backup could not be completed.': 'Nusxa yaratib bo‘lmadi.',
    'Preparing your backup': 'Nusxa tayyorlanmoqda',
    'Uploading your backup': 'Nusxa yuklanmoqda',
    'Backup ready for device transfer': 'Nusxa ko‘chirishga tayyor',
    'Get your data on this device': 'Ma’lumotlarni bu qurilmaga olish',
    'Downloading your data': 'Ma’lumotlar yuklab olinmoqda',
    'Restoring your data': 'Ma’lumotlar tiklanmoqda',
    'Your data is restored': 'Ma’lumotlaringiz tiklandi',
    'Backup needs attention': 'Nusxani tekshirish kerak',
    'Restore': 'Tiklash',
    'Available until': 'Mavjud sana',
    'Try again from Settings.': 'Sozlamalardan qayta urinib ko‘ring.',
    'Restore backup?': 'Nusxa tiklansinmi?',
    'This replaces the habit data currently stored on this phone with your saved backup.':
        'Bu telefondagi odat ma’lumotlari saqlangan nusxa bilan almashtiriladi.',
  },
};

const Map<String, Map<String, String>> _numericalHeatmapTranslations = {
  'en': {
    'Numerical habit heatmaps': 'Numerical habit heatmaps',
    'Create numerical heatmap': 'Create numerical heatmap',
    'No unused numerical habits are available.':
        'No unused numerical habits are available.',
    'Unlock two more numerical heatmaps?':
        'Unlock two more numerical heatmaps?',
    'Choose numerical habit': 'Choose numerical habit',
    'Less': 'Less',
    'More': 'More',
    'Which direction is better?': 'Which direction is better?',
    'More is better': 'More is better',
    'Less is better': 'Less is better',
    'Choose the value for each color': 'Choose the value for each color',
    'Color values must increase from orange to blue.':
        'Color values must increase from orange to blue.',
    'Color values must decrease from orange to blue.':
        'Color values must decrease from orange to blue.',
    'Orange': 'Orange',
    'Yellow': 'Yellow',
    'Green': 'Green',
    'Blue': 'Blue',
    'Hours': 'Hours',
    'Minutes': 'Minutes',
  },
  'es': {
    'Which direction is better?': '¿Qué dirección es mejor?',
    'More is better': 'Más es mejor',
    'Less is better': 'Menos es mejor',
    'Choose the value for each color': 'Elige el valor de cada color',
    'Color values must increase from orange to blue.':
        'Los valores deben aumentar de naranja a azul.',
    'Color values must decrease from orange to blue.':
        'Los valores deben disminuir de naranja a azul.',
    'Orange': 'Naranja',
    'Yellow': 'Amarillo',
    'Green': 'Verde',
    'Blue': 'Azul',
    'Hours': 'Horas',
    'Minutes': 'Minutos',
    'Numerical habit heatmaps': 'Mapas de hábitos numéricos',
    'Create numerical heatmap': 'Crear mapa numérico',
    'No unused numerical habits are available.':
        'No hay hábitos numéricos sin usar disponibles.',
    'Unlock two more numerical heatmaps?':
        '¿Desbloquear dos mapas numéricos más?',
    'Choose numerical habit': 'Elegir hábito numérico',
    'Less': 'Menos',
    'More': 'Más',
  },
  'ru': {
    'Which direction is better?': 'Какое направление лучше?',
    'More is better': 'Больше — лучше',
    'Less is better': 'Меньше — лучше',
    'Choose the value for each color': 'Выберите значение для каждого цвета',
    'Color values must increase from orange to blue.':
        'Значения должны увеличиваться от оранжевого к синему.',
    'Color values must decrease from orange to blue.':
        'Значения должны уменьшаться от оранжевого к синему.',
    'Orange': 'Оранжевый',
    'Yellow': 'Жёлтый',
    'Green': 'Зелёный',
    'Blue': 'Синий',
    'Hours': 'Часы',
    'Minutes': 'Минуты',
    'Numerical habit heatmaps': 'Тепловые карты числовых привычек',
    'Create numerical heatmap': 'Создать тепловую карту',
    'No unused numerical habits are available.':
        'Нет доступных неиспользованных числовых привычек.',
    'Unlock two more numerical heatmaps?':
        'Разблокировать ещё две тепловые карты?',
    'Choose numerical habit': 'Выберите числовую привычку',
    'Less': 'Меньше',
    'More': 'Больше',
  },
  'fr': {
    'Which direction is better?': 'Quelle direction est préférable ?',
    'More is better': 'Plus est préférable',
    'Less is better': 'Moins est préférable',
    'Choose the value for each color': 'Choisissez la valeur de chaque couleur',
    'Color values must increase from orange to blue.':
        'Les valeurs doivent augmenter de l’orange au bleu.',
    'Color values must decrease from orange to blue.':
        'Les valeurs doivent diminuer de l’orange au bleu.',
    'Orange': 'Orange',
    'Yellow': 'Jaune',
    'Green': 'Vert',
    'Blue': 'Bleu',
    'Hours': 'Heures',
    'Minutes': 'Minutes',
    'Numerical habit heatmaps': 'Cartes thermiques des habitudes numériques',
    'Create numerical heatmap': 'Créer une carte thermique',
    'No unused numerical habits are available.':
        'Aucune habitude numérique inutilisée n’est disponible.',
    'Unlock two more numerical heatmaps?':
        'Déverrouiller deux cartes thermiques supplémentaires ?',
    'Choose numerical habit': 'Choisir une habitude numérique',
    'Less': 'Moins',
    'More': 'Plus',
  },
  'uz': {
    'Which direction is better?': 'Qaysi yo‘nalish yaxshiroq?',
    'More is better': 'Ko‘proq — yaxshiroq',
    'Less is better': 'Kamroq — yaxshiroq',
    'Choose the value for each color': 'Har bir rang uchun qiymat tanlang',
    'Color values must increase from orange to blue.':
        'Qiymatlar to‘q sariqdan ko‘k ranggacha oshishi kerak.',
    'Color values must decrease from orange to blue.':
        'Qiymatlar to‘q sariqdan ko‘k ranggacha kamayishi kerak.',
    'Orange': 'To‘q sariq',
    'Yellow': 'Sariq',
    'Green': 'Yashil',
    'Blue': 'Ko‘k',
    'Hours': 'Soat',
    'Minutes': 'Daqiqa',
    'Numerical habit heatmaps': 'Raqamli odatlar issiqlik xaritasi',
    'Create numerical heatmap': 'Issiqlik xaritasi yaratish',
    'No unused numerical habits are available.':
        'Ishlatilmagan raqamli odatlar mavjud emas.',
    'Unlock two more numerical heatmaps?':
        'Yana ikkita issiqlik xaritasi ochilsinmi?',
    'Choose numerical habit': 'Raqamli odatni tanlang',
    'Less': 'Kam',
    'More': 'Ko‘p',
  },
};

const Map<String, Map<String, String>> _habitStreakTranslations = {
  'en': {
    'Habit streaks': 'Habit streaks',
    'Add streak': 'Add streak',
    'Add habit streak': 'Add habit streak',
    'Each streak grows only when that specific habit succeeds every day.':
        'Each streak grows only when that specific habit succeeds every day.',
    'Choose a habit to start its streak.':
        'Choose a habit to start its streak.',
    'No other active habits are available.':
        'No other active habits are available.',
    'Create this habit streak?': 'Create this habit streak?',
    'This habit streak requires 35 tokens.':
        'This habit streak requires 35 tokens.',
    'You need 35 tokens to create this habit streak.':
        'You need 35 tokens to create this habit streak.',
    'Choose streak color': 'Choose streak color',
    'Remove habit streak': 'Remove habit streak',
    'Remove habit streak?': 'Remove habit streak?',
    'Its streak setup will be removed.': 'Its streak setup will be removed.',
    'Two habit streaks, 35 tokens each': 'Two habit streaks, 35 tokens each',
    'Five habit streaks; 3 included and 2 cost 35 tokens':
        'Five habit streaks; 3 included and 2 cost 35 tokens',
    'Unlimited habit streaks with custom colors':
        'Unlimited habit streaks with custom colors',
  },
  'es': {
    'Habit streaks': 'Rachas de hábitos',
    'Add streak': 'Añadir racha',
    'Add habit streak': 'Añadir racha de hábito',
    'Each streak grows only when that specific habit succeeds every day.':
        'Cada racha crece solo cuando cumples ese hábito cada día.',
    'Choose a habit to start its streak.':
        'Elige un hábito para comenzar su racha.',
    'No other active habits are available.':
        'No hay otros hábitos activos disponibles.',
    'Create this habit streak?': '¿Crear esta racha de hábito?',
    'This habit streak requires 35 tokens.': 'Esta racha requiere 35 fichas.',
    'You need 35 tokens to create this habit streak.':
        'Necesitas 35 fichas para crear esta racha.',
    'Choose streak color': 'Elegir color de la racha',
    'Remove habit streak': 'Eliminar racha',
    'Remove habit streak?': '¿Eliminar la racha?',
    'Its streak setup will be removed.': 'Se eliminará su configuración.',
  },
  'ru': {
    'Habit streaks': 'Серии привычек',
    'Add streak': 'Добавить серию',
    'Add habit streak': 'Добавить серию привычки',
    'Each streak grows only when that specific habit succeeds every day.':
        'Серия растёт, только если эта привычка успешно выполняется каждый день.',
    'Choose a habit to start its streak.':
        'Выберите привычку, чтобы начать её серию.',
    'No other active habits are available.': 'Других активных привычек нет.',
    'Create this habit streak?': 'Создать эту серию привычки?',
    'This habit streak requires 35 tokens.':
        'Для этой серии требуется 35 токенов.',
    'You need 35 tokens to create this habit streak.':
        'Для создания этой серии нужно 35 токенов.',
    'Choose streak color': 'Выбрать цвет серии',
    'Remove habit streak': 'Удалить серию',
    'Remove habit streak?': 'Удалить серию привычки?',
    'Its streak setup will be removed.': 'Настройки серии будут удалены.',
  },
  'fr': {
    'Habit streaks': 'Séries d’habitudes',
    'Add streak': 'Ajouter une série',
    'Add habit streak': 'Ajouter une série d’habitude',
    'Each streak grows only when that specific habit succeeds every day.':
        'Chaque série progresse uniquement si cette habitude est réussie chaque jour.',
    'Choose a habit to start its streak.':
        'Choisissez une habitude pour commencer sa série.',
    'No other active habits are available.':
        'Aucune autre habitude active n’est disponible.',
    'Create this habit streak?': 'Créer cette série d’habitude ?',
    'This habit streak requires 35 tokens.': 'Cette série nécessite 35 jetons.',
    'You need 35 tokens to create this habit streak.':
        'Vous avez besoin de 35 jetons pour créer cette série.',
    'Choose streak color': 'Choisir la couleur de la série',
    'Remove habit streak': 'Supprimer la série',
    'Remove habit streak?': 'Supprimer la série d’habitude ?',
    'Its streak setup will be removed.': 'Sa configuration sera supprimée.',
  },
  'uz': {
    'Habit streaks': 'Odat seriyalari',
    'Add streak': 'Seriya qo‘shish',
    'Add habit streak': 'Odat seriyasini qo‘shish',
    'Each streak grows only when that specific habit succeeds every day.':
        'Har bir seriya faqat shu odat har kuni muvaffaqiyatli bajarilganda o‘sadi.',
    'Choose a habit to start its streak.':
        'Seriyasini boshlash uchun odat tanlang.',
    'No other active habits are available.': 'Boshqa faol odatlar mavjud emas.',
    'Create this habit streak?': 'Bu odat seriyasi yaratilsinmi?',
    'This habit streak requires 35 tokens.':
        'Bu odat seriyasi uchun 35 token kerak.',
    'You need 35 tokens to create this habit streak.':
        'Bu seriyani yaratish uchun 35 token kerak.',
    'Choose streak color': 'Seriya rangini tanlash',
    'Remove habit streak': 'Odat seriyasini olib tashlash',
    'Remove habit streak?': 'Odat seriyasi olib tashlansinmi?',
    'Its streak setup will be removed.': 'Uning seriya sozlamasi o‘chiriladi.',
  },
};

const Map<String, Map<String, String>> _measurementTranslations = {
  'en': {
    'Times': 'Times',
    'Hours and minutes': 'Hours and minutes',
    'hours': 'hours',
    'Target duration per day': 'Target duration per day',
    'How long did you do this habit?': 'How long did you do this habit?',
    'Duration on this day': 'Duration on this day',
    'Choose hours and minutes': 'Choose hours and minutes',
    'Different targets for certain days': 'Different targets for certain days',
    'Turn this on to give selected days a different daily target.':
        'Turn this on to give selected days a different daily target.',
    'The plan first grows your active days, then builds your daily target.':
        'The plan first grows your active days, then builds your daily target.',
  },
  'es': {
    'Times': 'Veces',
    'Hours and minutes': 'Horas y minutos',
    'hours': 'horas',
    'Target duration per day': 'Duración objetivo por día',
    'How long did you do this habit?': '¿Cuánto tiempo hiciste este hábito?',
    'Duration on this day': 'Duración en este día',
    'Choose hours and minutes': 'Elige horas y minutos',
    'Different targets for certain days':
        'Objetivos diferentes para ciertos días',
    'Turn this on to give selected days a different daily target.':
        'Actívalo para dar a ciertos días un objetivo diario diferente.',
    'The plan first grows your active days, then builds your daily target.':
        'El plan primero aumenta tus días activos y después desarrolla tu objetivo diario.',
  },
  'ru': {
    'Times': 'Раз',
    'Hours and minutes': 'Часы и минуты',
    'hours': 'часов',
    'Target duration per day': 'Целевая продолжительность в день',
    'How long did you do this habit?': 'Как долго вы выполняли эту привычку?',
    'Duration on this day': 'Продолжительность в этот день',
    'Choose hours and minutes': 'Выберите часы и минуты',
    'Different targets for certain days': 'Разные цели для отдельных дней',
    'Turn this on to give selected days a different daily target.':
        'Включите, чтобы задать выбранным дням другую ежедневную цель.',
    'The plan first grows your active days, then builds your daily target.':
        'Сначала план увеличивает число активных дней, затем постепенно повышает ежедневную цель.',
  },
  'fr': {
    'Times': 'Fois',
    'Hours and minutes': 'Heures et minutes',
    'hours': 'heures',
    'Target duration per day': 'Durée visée par jour',
    'How long did you do this habit?':
        'Combien de temps avez-vous pratiqué cette habitude ?',
    'Duration on this day': 'Durée ce jour-là',
    'Choose hours and minutes': 'Choisissez les heures et les minutes',
    'Different targets for certain days':
        'Objectifs différents selon les jours',
    'Turn this on to give selected days a different daily target.':
        'Activez cette option pour donner aux jours choisis un objectif quotidien différent.',
    'The plan first grows your active days, then builds your daily target.':
        'Le plan augmente d’abord vos jours actifs, puis développe progressivement votre objectif quotidien.',
  },
  'uz': {
    'Times': 'Marta',
    'Hours and minutes': 'Soat va daqiqa',
    'hours': 'soat',
    'Target duration per day': 'Kunlik davomiylik maqsadi',
    'How long did you do this habit?': 'Bu odatni qancha vaqt bajardingiz?',
    'Duration on this day': 'Bu kundagi davomiylik',
    'Choose hours and minutes': 'Soat va daqiqani tanlang',
    'Different targets for certain days': 'Ayrim kunlar uchun boshqa maqsadlar',
    'Turn this on to give selected days a different daily target.':
        'Tanlangan kunlarga boshqa kunlik maqsad berish uchun yoqing.',
    'The plan first grows your active days, then builds your daily target.':
        'Reja avval faol kunlarni ko‘paytiradi, keyin kunlik maqsadni bosqichma-bosqich oshiradi.',
  },
};

const Map<String, Map<String, String>> _growthTranslations = {
  'en': {
    'Gradual growth': 'Gradual growth',
    'Gradual-growth calendar': 'Gradual-growth calendar',
    'Fast': 'Fast',
    'Medium': 'Medium',
    'Slow': 'Slow',
    'Create growth plan': 'Create growth plan',
    'Change growth plan': 'Change growth plan',
    'Choose good habit': 'Choose good habit',
    'Target days per week': 'Target days per week',
    'Target repetitions per day': 'Target repetitions per day',
    'Target duration per day': 'Target duration per day',
    'Days off': 'Days off',
    'How many repetitions did you complete?':
        'How many repetitions did you complete?',
    'How long did you do this habit?': 'How long did you do this habit?',
    'Choose hours and minutes': 'Choose hours and minutes',
    'The plan first grows your active days, then builds repetitions on those days.':
        'The plan first grows your active days, then builds repetitions on those days.',
    'The plan first grows your active days, then builds your daily target.':
        'The plan first grows your active days, then builds your daily target.',
    'Build a good habit gently by increasing its weekly days and daily repetitions.':
        'Build a good habit gently by increasing its weekly days and daily repetitions.',
    'Unlock and create': 'Unlock and create',
    'Unlock more growth plans': 'Unlock more growth plans',
    'Unlock these gradual-growth plans for 7 days?':
        'Unlock these gradual-growth plans for 7 days?',
    'Change this growth plan?': 'Change this growth plan?',
    'Changing it replaces the current growth schedule.':
        'Changing it replaces the current growth schedule.',
    'Unlock these reduction plans for 7 days?':
        'Unlock these reduction plans for 7 days?',
    'per week': 'per week',
    'Target': 'Target',
    'Choose habit days': 'Choose habit days',
    'Unselected days are your days off.': 'Unselected days are your days off.',
    'Unlock and create growth plan': 'Unlock and create growth plan',
    'Create reduction plan': 'Create reduction plan',
    'Different repetitions for certain days':
        'Different repetitions for certain days',
    'Different targets for certain days': 'Different targets for certain days',
    'Turn on a day to give it a different target from the general repetition target.':
        'Turn on a day to give it a different target from the general repetition target.',
    'Repetitions on this day': 'Repetitions on this day',
    'Duration on this day': 'Duration on this day',
    'Turn this on to give selected days a different repetition target.':
        'Turn this on to give selected days a different repetition target.',
    'Turn this on to give selected days a different daily target.':
        'Turn this on to give selected days a different daily target.',
    'Enter value manually': 'Enter value manually',
    'Enter a valid value': 'Enter a valid value',
    'Monday': 'Monday',
    'Tuesday': 'Tuesday',
    'Wednesday': 'Wednesday',
    'Thursday': 'Thursday',
    'Friday': 'Friday',
    'Saturday': 'Saturday',
    'Sunday': 'Sunday',
    'Main gradual-growth plan without weekly locks':
        'Main gradual-growth plan without weekly locks',
    'Three gradual-growth plans; the two extra plans share one weekly 70-token unlock':
        'Three gradual-growth plans; the two extra plans share one weekly 70-token unlock',
    'The first three gradual-growth plans without token or ad unlocks':
        'The first three gradual-growth plans without token or ad unlocks',
    'Six gradual-growth plans; the last 3 share one weekly 70-token unlock':
        'Six gradual-growth plans; the last 3 share one weekly 70-token unlock',
    'Four gradual-reduction plans; the last 2 share one weekly 35-token unlock':
        'Four gradual-reduction plans; the last 2 share one weekly 35-token unlock',
    'Unlimited gradual-growth and gradual-reduction plans without token unlocks':
        'Unlimited gradual-growth and gradual-reduction plans without token unlocks',
  },
  'es': {
    'Gradual growth': 'Crecimiento gradual',
    'Gradual-growth calendar': 'Calendario de crecimiento gradual',
    'Fast': 'Rápido',
    'Medium': 'Medio',
    'Slow': 'Lento',
    'Create growth plan': 'Crear plan de crecimiento',
    'Change growth plan': 'Cambiar plan de crecimiento',
    'Choose good habit': 'Elige un hábito positivo',
    'Target days per week': 'Días objetivo por semana',
    'Target repetitions per day': 'Repeticiones objetivo por día',
    'Days off': 'Días de descanso',
    'How many repetitions did you complete?':
        '¿Cuántas repeticiones completaste?',
    'The plan first grows your active days, then builds repetitions on those days.':
        'El plan primero aumenta tus días activos y después las repeticiones de esos días.',
    'Build a good habit gently by increasing its weekly days and daily repetitions.':
        'Desarrolla un buen hábito aumentando poco a poco los días semanales y las repeticiones diarias.',
    'Unlock and create': 'Desbloquear y crear',
    'Unlock more growth plans': 'Desbloquear más planes de crecimiento',
    'Unlock these gradual-growth plans for 7 days?':
        '¿Desbloquear estos planes de crecimiento gradual durante 7 días?',
    'Change this growth plan?': '¿Cambiar este plan de crecimiento?',
    'Changing it replaces the current growth schedule.':
        'Al cambiarlo se sustituirá el calendario de crecimiento actual.',
    'Unlock these reduction plans for 7 days?':
        '¿Desbloquear estos planes de reducción durante 7 días?',
    'per week': 'por semana',
    'Target': 'Objetivo',
    'Choose habit days': 'Elige los días del hábito',
    'Unselected days are your days off.':
        'Los días no seleccionados son tus días de descanso.',
    'Unlock and create growth plan': 'Desbloquear y crear plan de crecimiento',
    'Create reduction plan': 'Crear plan de reducción',
    'Different repetitions for certain days':
        'Repeticiones diferentes para ciertos días',
    'Turn on a day to give it a different target from the general repetition target.':
        'Activa un día para darle un objetivo diferente al objetivo general.',
    'Repetitions on this day': 'Repeticiones este día',
    'Turn this on to give selected days a different repetition target.':
        'Actívalo para dar a ciertos días un objetivo de repeticiones diferente.',
    'Enter value manually': 'Introducir el valor manualmente',
    'Enter a valid value': 'Introduce un valor válido',
    'Monday': 'Lunes',
    'Tuesday': 'Martes',
    'Wednesday': 'Miércoles',
    'Thursday': 'Jueves',
    'Friday': 'Viernes',
    'Saturday': 'Sábado',
    'Sunday': 'Domingo',
    'Main gradual-growth plan without weekly locks':
        'Plan principal de crecimiento sin bloqueos semanales',
    'Three gradual-growth plans; the two extra plans share one weekly 70-token unlock':
        'Tres planes de crecimiento; los dos extra comparten un desbloqueo semanal de 70 fichas',
    'The first three gradual-growth plans without token or ad unlocks':
        'Los tres primeros planes de crecimiento sin fichas ni anuncios',
    'Six gradual-growth plans; the last 3 share one weekly 70-token unlock':
        'Seis planes de crecimiento; los últimos 3 comparten un desbloqueo semanal de 70 fichas',
    'Four gradual-reduction plans; the last 2 share one weekly 35-token unlock':
        'Cuatro planes de reducción; los últimos 2 comparten un desbloqueo semanal de 35 fichas',
    'Unlimited gradual-growth and gradual-reduction plans without token unlocks':
        'Planes ilimitados de crecimiento y reducción sin desbloqueos con fichas',
  },
  'ru': {
    'Gradual growth': 'Постепенное развитие',
    'Gradual-growth calendar': 'Календарь постепенного развития',
    'Fast': 'Быстро',
    'Medium': 'Средне',
    'Slow': 'Медленно',
    'Create growth plan': 'Создать план развития',
    'Change growth plan': 'Изменить план развития',
    'Choose good habit': 'Выберите полезную привычку',
    'Target days per week': 'Целевых дней в неделю',
    'Target repetitions per day': 'Целевых повторений в день',
    'Days off': 'Дни отдыха',
    'How many repetitions did you complete?':
        'Сколько повторений вы выполнили?',
    'The plan first grows your active days, then builds repetitions on those days.':
        'Сначала план увеличивает число активных дней, затем — количество повторений в эти дни.',
    'Build a good habit gently by increasing its weekly days and daily repetitions.':
        'Развивайте полезную привычку постепенно, увеличивая дни и ежедневные повторения.',
    'Unlock and create': 'Разблокировать и создать',
    'Unlock more growth plans': 'Открыть больше планов развития',
    'Unlock these gradual-growth plans for 7 days?':
        'Разблокировать эти планы постепенного развития на 7 дней?',
    'Change this growth plan?': 'Изменить этот план развития?',
    'Changing it replaces the current growth schedule.':
        'Изменение заменит текущее расписание развития.',
    'Unlock these reduction plans for 7 days?':
        'Разблокировать эти планы сокращения на 7 дней?',
    'per week': 'в неделю',
    'Target': 'Цель',
    'Choose habit days': 'Выберите дни привычки',
    'Unselected days are your days off.': 'Невыбранные дни будут днями отдыха.',
    'Unlock and create growth plan': 'Разблокировать и создать план развития',
    'Create reduction plan': 'Создать план сокращения',
    'Different repetitions for certain days':
        'Разное число повторений в отдельные дни',
    'Turn on a day to give it a different target from the general repetition target.':
        'Включите день, чтобы задать для него цель, отличную от общей.',
    'Repetitions on this day': 'Повторений в этот день',
    'Turn this on to give selected days a different repetition target.':
        'Включите, чтобы задать выбранным дням другую цель повторений.',
    'Enter value manually': 'Ввести значение вручную',
    'Enter a valid value': 'Введите допустимое значение',
    'Monday': 'Понедельник',
    'Tuesday': 'Вторник',
    'Wednesday': 'Среда',
    'Thursday': 'Четверг',
    'Friday': 'Пятница',
    'Saturday': 'Суббота',
    'Sunday': 'Воскресенье',
    'Main gradual-growth plan without weekly locks':
        'Основной план развития без еженедельной блокировки',
    'Three gradual-growth plans; the two extra plans share one weekly 70-token unlock':
        'Три плана развития; два дополнительных имеют общую недельную разблокировку за 70 токенов',
    'The first three gradual-growth plans without token or ad unlocks':
        'Первые три плана развития без токенов и рекламы',
    'Six gradual-growth plans; the last 3 share one weekly 70-token unlock':
        'Шесть планов развития; последние 3 имеют общую недельную разблокировку за 70 токенов',
    'Four gradual-reduction plans; the last 2 share one weekly 35-token unlock':
        'Четыре плана сокращения; последние 2 имеют общую недельную разблокировку за 35 токенов',
    'Unlimited gradual-growth and gradual-reduction plans without token unlocks':
        'Неограниченные планы развития и сокращения без разблокировки токенами',
  },
  'fr': {
    'Gradual growth': 'Progression graduelle',
    'Gradual-growth calendar': 'Calendrier de progression graduelle',
    'Fast': 'Rapide',
    'Medium': 'Moyen',
    'Slow': 'Lent',
    'Create growth plan': 'Créer un plan de progression',
    'Change growth plan': 'Modifier le plan de progression',
    'Choose good habit': 'Choisissez une bonne habitude',
    'Target days per week': 'Jours visés par semaine',
    'Target repetitions per day': 'Répétitions visées par jour',
    'Days off': 'Jours de repos',
    'How many repetitions did you complete?':
        'Combien de répétitions avez-vous effectuées ?',
    'The plan first grows your active days, then builds repetitions on those days.':
        'Le plan augmente d’abord vos jours actifs, puis les répétitions pendant ces jours.',
    'Build a good habit gently by increasing its weekly days and daily repetitions.':
        'Développez une bonne habitude progressivement en augmentant les jours et répétitions.',
    'Unlock and create': 'Débloquer et créer',
    'Unlock more growth plans': 'Débloquer plus de plans de progression',
    'Unlock these gradual-growth plans for 7 days?':
        'Débloquer ces plans de progression pendant 7 jours ?',
    'Change this growth plan?': 'Modifier ce plan de progression ?',
    'Changing it replaces the current growth schedule.':
        'Cette modification remplacera le calendrier de progression actuel.',
    'Unlock these reduction plans for 7 days?':
        'Débloquer ces plans de réduction pendant 7 jours ?',
    'per week': 'par semaine',
    'Target': 'Objectif',
    'Choose habit days': 'Choisissez les jours de l’habitude',
    'Unselected days are your days off.':
        'Les jours non sélectionnés sont vos jours de repos.',
    'Unlock and create growth plan':
        'Débloquer et créer un plan de progression',
    'Create reduction plan': 'Créer un plan de réduction',
    'Different repetitions for certain days':
        'Répétitions différentes certains jours',
    'Turn on a day to give it a different target from the general repetition target.':
        'Activez un jour pour lui donner un objectif différent de l’objectif général.',
    'Repetitions on this day': 'Répétitions ce jour-là',
    'Turn this on to give selected days a different repetition target.':
        'Activez cette option pour donner un objectif différent à certains jours.',
    'Enter value manually': 'Saisir la valeur manuellement',
    'Enter a valid value': 'Saisissez une valeur valide',
    'Monday': 'Lundi',
    'Tuesday': 'Mardi',
    'Wednesday': 'Mercredi',
    'Thursday': 'Jeudi',
    'Friday': 'Vendredi',
    'Saturday': 'Samedi',
    'Sunday': 'Dimanche',
    'Main gradual-growth plan without weekly locks':
        'Plan principal de progression sans verrouillage hebdomadaire',
    'Three gradual-growth plans; the two extra plans share one weekly 70-token unlock':
        'Trois plans de progression ; les deux supplémentaires partagent un déblocage hebdomadaire de 70 jetons',
    'The first three gradual-growth plans without token or ad unlocks':
        'Les trois premiers plans de progression sans jetons ni publicité',
    'Six gradual-growth plans; the last 3 share one weekly 70-token unlock':
        'Six plans de progression ; les 3 derniers partagent un déblocage hebdomadaire de 70 jetons',
    'Four gradual-reduction plans; the last 2 share one weekly 35-token unlock':
        'Quatre plans de réduction ; les 2 derniers partagent un déblocage hebdomadaire de 35 jetons',
    'Unlimited gradual-growth and gradual-reduction plans without token unlocks':
        'Plans de progression et de réduction illimités sans déblocage par jetons',
  },
  'uz': {
    'Gradual growth': 'Bosqichma-bosqich rivojlantirish',
    'Gradual-growth calendar': 'Bosqichma-bosqich rivojlanish taqvimi',
    'Fast': 'Tez',
    'Medium': 'O‘rtacha',
    'Slow': 'Sekin',
    'Create growth plan': 'Rivojlanish rejasini yaratish',
    'Change growth plan': 'Rivojlanish rejasini o‘zgartirish',
    'Choose good habit': 'Yaxshi odatni tanlang',
    'Target days per week': 'Haftalik maqsad kunlari',
    'Target repetitions per day': 'Kunlik maqsad takrorlari',
    'Days off': 'Dam olish kunlari',
    'How many repetitions did you complete?': 'Nechta takrorni bajardingiz?',
    'The plan first grows your active days, then builds repetitions on those days.':
        'Reja avval faol kunlarni, keyin esa shu kunlardagi takrorlarni oshiradi.',
    'Build a good habit gently by increasing its weekly days and daily repetitions.':
        'Haftalik kunlar va kunlik takrorlarni asta oshirib, yaxshi odatni rivojlantiring.',
    'Unlock and create': 'Ochish va yaratish',
    'Unlock more growth plans': 'Ko‘proq rivojlanish rejalarini ochish',
    'Unlock these gradual-growth plans for 7 days?':
        'Bu rivojlanish rejalarini 7 kunga ochasizmi?',
    'Change this growth plan?': 'Bu rivojlanish rejasini o‘zgartirasizmi?',
    'Changing it replaces the current growth schedule.':
        'O‘zgartirish hozirgi rivojlanish jadvalini almashtiradi.',
    'Unlock these reduction plans for 7 days?':
        'Bu kamaytirish rejalarini 7 kunga ochasizmi?',
    'per week': 'haftasiga',
    'Target': 'Maqsad',
    'Choose habit days': 'Odat kunlarini tanlang',
    'Unselected days are your days off.':
        'Tanlanmagan kunlar dam olish kunlaringiz bo‘ladi.',
    'Unlock and create growth plan': 'Rivojlanish rejasini ochish va yaratish',
    'Create reduction plan': 'Kamaytirish rejasini yaratish',
    'Different repetitions for certain days':
        'Ayrim kunlar uchun boshqa takrorlar',
    'Turn on a day to give it a different target from the general repetition target.':
        'Kunga umumiy takror maqsadidan farqli maqsad berish uchun uni yoqing.',
    'Repetitions on this day': 'Bu kundagi takrorlar',
    'Turn this on to give selected days a different repetition target.':
        'Tanlangan kunlarga boshqa takror maqsadini berish uchun buni yoqing.',
    'Enter value manually': 'Qiymatni qo‘lda kiriting',
    'Enter a valid value': 'To‘g‘ri qiymat kiriting',
    'Monday': 'Dushanba',
    'Tuesday': 'Seshanba',
    'Wednesday': 'Chorshanba',
    'Thursday': 'Payshanba',
    'Friday': 'Juma',
    'Saturday': 'Shanba',
    'Sunday': 'Yakshanba',
    'Main gradual-growth plan without weekly locks':
        'Haftalik qulfsiz asosiy rivojlanish rejasi',
    'Three gradual-growth plans; the two extra plans share one weekly 70-token unlock':
        'Uchta rivojlanish rejasi; ikkita qo‘shimcha reja bitta haftalik 70 tokenlik ochishni ulashadi',
    'The first three gradual-growth plans without token or ad unlocks':
        'Dastlabki uchta rivojlanish rejasi token yoki reklamasiz',
    'Six gradual-growth plans; the last 3 share one weekly 70-token unlock':
        'Oltita rivojlanish rejasi; oxirgi 3 tasi bitta haftalik 70 tokenlik ochishni ulashadi',
    'Four gradual-reduction plans; the last 2 share one weekly 35-token unlock':
        'To‘rtta kamaytirish rejasi; oxirgi 2 tasi bitta haftalik 35 tokenlik ochishni ulashadi',
    'Unlimited gradual-growth and gradual-reduction plans without token unlocks':
        'Tokensiz cheksiz rivojlanish va kamaytirish rejalari',
  },
};

const Map<String, Map<String, String>> _bodyMuscleTranslations = {
  'en': {
    'Group graphs': 'Group graphs',
    'Group graph': 'Group graph',
    'Create a group graph': 'Create a group graph',
    'Unlock this group graph for 7 days': 'Unlock this group graph for 7 days',
    'Do you want to unlock this group graph?':
        'Do you want to unlock this group graph?',
    'One group graph with a weekly 70-token unlock':
        'One group graph with a weekly 70-token unlock',
    'Four group graphs: 2 included and 2 weekly 35-token unlocks':
        'Four group graphs: 2 included and 2 weekly 35-token unlocks',
    'Six included group graphs': 'Six included group graphs',
    'Upgrade to': 'Upgrade to',
    'Upgrade to Plus': 'Upgrade to Plus',
    'Upgrade to Plus to unlock': 'Upgrade to Plus to unlock',
    'Unlock other organs with premium': 'Unlock other organs with premium',
    'Create another group graph': 'Create another group graph',
    'Create another individual graph': 'Create another individual graph',
    'Create a second reduction plan': 'Create a second reduction plan',
    'Front': 'Front',
    'Back view': 'Back',
    'Shoulder workout': 'Shoulder',
    'Back workout': 'Back',
  },
  'es': {
    'Group graphs': 'Gráficos de grupo',
    'Group graph': 'Gráfico de grupo',
    'Create a group graph': 'Crear un gráfico de grupo',
    'Unlock this group graph for 7 days':
        'Desbloquea este gráfico de grupo durante 7 días',
    'Do you want to unlock this group graph?':
        '¿Quieres desbloquear este gráfico de grupo?',
    'One group graph with a weekly 70-token unlock':
        'Un gráfico de grupo desbloqueable por 70 fichas durante una semana',
    'Four group graphs: 2 included and 2 weekly 35-token unlocks':
        'Cuatro gráficos de grupo: 2 incluidos y 2 desbloqueables semanalmente por 35 fichas',
    'Six included group graphs': 'Seis gráficos de grupo incluidos',
    'Upgrade to': 'Mejorar a',
    'Upgrade to Plus': 'Mejorar a Plus',
    'Upgrade to Plus to unlock': 'Mejora a Plus para desbloquear',
    'Unlock other organs with premium': 'Desbloquea otros órganos con premium',
    'Create another group graph': 'Crear otro gráfico de grupo',
    'Create another individual graph': 'Crear otro gráfico individual',
    'Create a second reduction plan': 'Crear un segundo plan de reducción',
    'Front': 'Frente',
    'Back view': 'Espalda',
    'Shoulder workout': 'Hombros',
    'Back workout': 'Espalda',
  },
  'ru': {
    'Group graphs': 'Групповые графики',
    'Group graph': 'Групповой график',
    'Create a group graph': 'Создать групповой график',
    'Unlock this group graph for 7 days':
        'Открыть этот групповой график на 7 дней',
    'Do you want to unlock this group graph?':
        'Хотите открыть этот групповой график?',
    'One group graph with a weekly 70-token unlock':
        'Один групповой график с недельным открытием за 70 жетонов',
    'Four group graphs: 2 included and 2 weekly 35-token unlocks':
        'Четыре групповых графика: 2 включены, 2 открываются на неделю за 35 жетонов',
    'Six included group graphs': 'Шесть включённых групповых графиков',
    'Upgrade to': 'Перейти на',
    'Upgrade to Plus': 'Перейти на Plus',
    'Upgrade to Plus to unlock': 'Перейдите на Plus, чтобы открыть',
    'Unlock other organs with premium': 'Откройте другие органы с премиумом',
    'Create another group graph': 'Создать ещё один групповой график',
    'Create another individual graph': 'Создать ещё один отдельный график',
    'Create a second reduction plan': 'Создать второй план сокращения',
    'Front': 'Спереди',
    'Back view': 'Сзади',
    'Shoulder workout': 'Плечи',
    'Back workout': 'Спина',
  },
  'fr': {
    'Group graphs': 'Graphiques de groupe',
    'Group graph': 'Graphique de groupe',
    'Create a group graph': 'Créer un graphique de groupe',
    'Unlock this group graph for 7 days':
        'Déverrouiller ce graphique de groupe pendant 7 jours',
    'Do you want to unlock this group graph?':
        'Voulez-vous déverrouiller ce graphique de groupe ?',
    'One group graph with a weekly 70-token unlock':
        'Un graphique de groupe déverrouillable une semaine pour 70 jetons',
    'Four group graphs: 2 included and 2 weekly 35-token unlocks':
        'Quatre graphiques de groupe : 2 inclus et 2 déverrouillables une semaine pour 35 jetons',
    'Six included group graphs': 'Six graphiques de groupe inclus',
    'Upgrade to': 'Passer à',
    'Upgrade to Plus': 'Passer à Plus',
    'Upgrade to Plus to unlock': 'Passez à Plus pour déverrouiller',
    'Unlock other organs with premium':
        'Déverrouillez les autres organes avec premium',
    'Create another group graph': 'Créer un autre graphique de groupe',
    'Create another individual graph': 'Créer un autre graphique individuel',
    'Create a second reduction plan': 'Créer un deuxième plan de réduction',
    'Front': 'Avant',
    'Back view': 'Dos',
    'Shoulder workout': 'Épaules',
    'Back workout': 'Dos',
  },
  'uz': {
    'Group graphs': 'Guruh grafiklari',
    'Group graph': 'Guruh grafigi',
    'Create a group graph': 'Guruh grafigini yaratish',
    'Unlock this group graph for 7 days': 'Bu guruh grafigini 7 kunga ochish',
    'Do you want to unlock this group graph?':
        'Bu guruh grafigini ochmoqchimisiz?',
    'One group graph with a weekly 70-token unlock':
        'Bir haftaga 70 token bilan ochiladigan bitta guruh grafigi',
    'Four group graphs: 2 included and 2 weekly 35-token unlocks':
        'To‘rtta guruh grafigi: 2 tasi kiritilgan, 2 tasi haftasiga 35 token',
    'Six included group graphs': 'Oltita kiritilgan guruh grafigi',
    'Upgrade to': 'Quyidagiga o‘tish',
    'Upgrade to Plus': 'Plus tarifiga o‘tish',
    'Upgrade to Plus to unlock': 'Ochish uchun Plus tarifiga o‘ting',
    'Unlock other organs with premium':
        'Boshqa organlarni premium bilan oching',
    'Create another group graph': 'Yana bir guruh grafigini yaratish',
    'Create another individual graph': 'Yana bir alohida grafik yaratish',
    'Create a second reduction plan': 'Ikkinchi kamaytirish rejasini yaratish',
    'Front': 'Oldi',
    'Back view': 'Orqasi',
    'Shoulder workout': 'Yelka',
    'Back workout': 'Orqa',
  },
};

const Map<String, Map<String, String>> _organReportTranslations = {
  'en': {
    'Organ reports': 'Organ reports',
    'Symbolic habit progress, not medical status.':
        'Symbolic habit progress, not medical status.',
    'Condition': 'Condition',
    'Needs attention': 'Needs attention',
    'Building stability': 'Building stability',
    'Steady progress': 'Steady progress',
    'Doing well': 'Doing well',
    'Excellent progress': 'Excellent progress',
    'Progress needs a reset': 'Progress needs a reset',
    'Small steps matter now': 'Small steps matter now',
    'More consistency will help': 'More consistency will help',
    'A better rhythm can start today': 'A better rhythm can start today',
    'Holding a balanced course': 'Holding a balanced course',
    'Keep the momentum moving': 'Keep the momentum moving',
    'Positive habits are showing': 'Positive habits are showing',
    'Strong and steady progress': 'Strong and steady progress',
    'Consistency is paying off': 'Consistency is paying off',
    'Keep up the great rhythm': 'Keep up the great rhythm',
  },
  'es': {
    'Organ reports': 'Informes de órganos',
    'Symbolic habit progress, not medical status.':
        'Progreso simbólico de hábitos, no es un estado médico.',
    'Condition': 'Condición',
    'Needs attention': 'Necesita atención',
    'Building stability': 'Desarrollando estabilidad',
    'Steady progress': 'Progreso estable',
    'Doing well': 'Va bien',
    'Excellent progress': 'Progreso excelente',
    'Progress needs a reset': 'El progreso necesita un nuevo comienzo',
    'Small steps matter now': 'Los pequeños pasos importan ahora',
    'More consistency will help': 'Más constancia ayudará',
    'A better rhythm can start today': 'Un mejor ritmo puede empezar hoy',
    'Holding a balanced course': 'Manteniendo un rumbo equilibrado',
    'Keep the momentum moving': 'Mantén el impulso',
    'Positive habits are showing': 'Los hábitos positivos se están notando',
    'Strong and steady progress': 'Progreso firme y constante',
    'Consistency is paying off': 'La constancia está dando resultados',
    'Keep up the great rhythm': 'Mantén este gran ritmo',
  },
  'ru': {
    'Organ reports': 'Отчёты об органах',
    'Symbolic habit progress, not medical status.':
        'Символический прогресс привычек, а не медицинская оценка.',
    'Condition': 'Состояние',
    'Needs attention': 'Требует внимания',
    'Building stability': 'Стабильность улучшается',
    'Steady progress': 'Стабильный прогресс',
    'Doing well': 'Хороший прогресс',
    'Excellent progress': 'Отличный прогресс',
    'Progress needs a reset': 'Прогрессу нужен новый старт',
    'Small steps matter now': 'Сейчас важны маленькие шаги',
    'More consistency will help': 'Больше постоянства поможет',
    'A better rhythm can start today': 'Лучший ритм можно начать сегодня',
    'Holding a balanced course': 'Сохраняется равномерный курс',
    'Keep the momentum moving': 'Продолжайте сохранять темп',
    'Positive habits are showing': 'Положительные привычки дают результат',
    'Strong and steady progress': 'Уверенный и стабильный прогресс',
    'Consistency is paying off': 'Постоянство приносит результат',
    'Keep up the great rhythm': 'Сохраняйте отличный ритм',
  },
  'fr': {
    'Organ reports': 'Rapports des organes',
    'Symbolic habit progress, not medical status.':
        'Progression symbolique des habitudes, pas un état médical.',
    'Condition': 'État',
    'Needs attention': 'Nécessite de l’attention',
    'Building stability': 'Stabilité en progression',
    'Steady progress': 'Progression stable',
    'Doing well': 'Bonne progression',
    'Excellent progress': 'Excellente progression',
    'Progress needs a reset': 'La progression a besoin d’un nouveau départ',
    'Small steps matter now': 'Les petits pas comptent maintenant',
    'More consistency will help': 'Plus de régularité aidera',
    'A better rhythm can start today':
        'Un meilleur rythme peut commencer aujourd’hui',
    'Holding a balanced course': 'Un rythme équilibré se maintient',
    'Keep the momentum moving': 'Gardez cet élan',
    'Positive habits are showing':
        'Les habitudes positives portent leurs fruits',
    'Strong and steady progress': 'Progression forte et régulière',
    'Consistency is paying off': 'La régularité porte ses fruits',
    'Keep up the great rhythm': 'Continuez sur cet excellent rythme',
  },
  'uz': {
    'Organ reports': 'Organ hisobotlari',
    'Symbolic habit progress, not medical status.':
        'Odatlarning ramziy rivoji, tibbiy holat emas.',
    'Condition': 'Holat',
    'Needs attention': 'E’tibor kerak',
    'Building stability': 'Barqarorlik shakllanmoqda',
    'Steady progress': 'Barqaror rivoj',
    'Doing well': 'Yaxshi ketmoqda',
    'Excellent progress': 'A’lo rivoj',
    'Progress needs a reset': 'Rivojga yangi boshlanish kerak',
    'Small steps matter now': 'Hozir kichik qadamlar muhim',
    'More consistency will help': 'Ko‘proq izchillik yordam beradi',
    'A better rhythm can start today': 'Yaxshiroq ritmni bugun boshlash mumkin',
    'Holding a balanced course': 'Muvozanatli yo‘nalish saqlanmoqda',
    'Keep the momentum moving': 'Shu sur’atni davom ettiring',
    'Positive habits are showing': 'Ijobiy odatlar natija bermoqda',
    'Strong and steady progress': 'Kuchli va barqaror rivoj',
    'Consistency is paying off': 'Izchillik o‘z samarasini bermoqda',
    'Keep up the great rhythm': 'Ajoyib ritmni saqlang',
  },
};

const Map<String, Map<String, String>> _singleGraphTranslations = {
  'en': {
    'Create an individual graph': 'Create an individual graph',
    'Do you want to unlock these individual graphs?':
        'Do you want to unlock these individual graphs?',
    'Daily': 'Daily',
    'Weekly': 'Weekly',
    'Monthly': 'Monthly',
    'Yearly': 'Yearly',
    'Numerical entries use their recorded value. Thumbs use these fallback values.':
        'Numerical entries use their recorded value. Thumbs use these fallback values.',
  },
  'es': {
    'Create an individual graph': 'Crear un gráfico individual',
    'Do you want to unlock these individual graphs?':
        '¿Quieres desbloquear estos gráficos individuales?',
    'Daily': 'Diario',
    'Weekly': 'Semanal',
    'Monthly': 'Mensual',
    'Yearly': 'Anual',
    'Numerical entries use their recorded value. Thumbs use these fallback values.':
        'Las entradas numéricas usan su valor registrado. Los pulgares usan estos valores alternativos.',
  },
  'ru': {
    'Create an individual graph': 'Создать отдельный график',
    'Do you want to unlock these individual graphs?':
        'Хотите разблокировать эти отдельные графики?',
    'Daily': 'Ежедневно',
    'Weekly': 'Еженедельно',
    'Monthly': 'Ежемесячно',
    'Yearly': 'Ежегодно',
    'Numerical entries use their recorded value. Thumbs use these fallback values.':
        'Числовые записи используют сохранённое значение. Для кнопок используются эти запасные значения.',
  },
  'fr': {
    'Create an individual graph': 'Créer un graphique individuel',
    'Do you want to unlock these individual graphs?':
        'Voulez-vous déverrouiller ces graphiques individuels ?',
    'Daily': 'Quotidien',
    'Weekly': 'Hebdomadaire',
    'Monthly': 'Mensuel',
    'Yearly': 'Annuel',
    'Numerical entries use their recorded value. Thumbs use these fallback values.':
        'Les saisies numériques utilisent leur valeur enregistrée. Les pouces utilisent ces valeurs de remplacement.',
  },
  'uz': {
    'Create an individual graph': 'Alohida grafik yaratish',
    'Do you want to unlock these individual graphs?':
        'Ushbu alohida grafiklarni ochmoqchimisiz?',
    'Daily': 'Kunlik',
    'Weekly': 'Haftalik',
    'Monthly': 'Oylik',
    'Yearly': 'Yillik',
    'Numerical entries use their recorded value. Thumbs use these fallback values.':
        'Raqamli yozuvlar saqlangan qiymatdan foydalanadi. Barmoq tugmalari ushbu zaxira qiymatlardan foydalanadi.',
  },
};

const Map<String, Map<String, String>> _namedGraphTranslations = {
  'en': {
    'Named custom graphs': 'Group graphs',
    'Named custom graph': 'Group graph',
    'Create a habit group': 'Create a group graph',
    'Unlock this named graph for 7 days': 'Unlock this group graph for 7 days',
    'Tap to choose tokens or an ad': 'Tap to choose tokens or an ad',
    'Do you want to unlock this named graph?':
        'Do you want to unlock this group graph?',
    'Graph name': 'Graph name',
    'Add habit slot': 'Add habit slot',
    'Enter a graph name.': 'Enter a graph name.',
    'Choose at least one habit.': 'Choose at least one habit.',
    'Main custom graph with 6 habit slots':
        'Main custom graph with 6 habit slots',
    'One named graph with a weekly 70-token unlock':
        'One group graph with a weekly 70-token unlock',
    'Main custom graph with 10 slots; the last 4 cost 35 tokens to change':
        'Main custom graph with 10 slots; the last 4 cost 35 tokens to change',
    'Four named graphs: 2 included and 2 weekly 35-token unlocks':
        'Four group graphs: 2 included and 2 weekly 35-token unlocks',
    'Unlimited main custom-graph habit slots':
        'Unlimited main custom-graph habit slots',
    'Six included named custom graphs': 'Six included group graphs',
  },
  'es': {
    'Named custom graphs': 'Gráficos personalizados con nombre',
    'Named custom graph': 'Gráfico personalizado con nombre',
    'Create a habit group': 'Crear un grupo de hábitos',
    'Unlock this named graph for 7 days':
        'Desbloquea este gráfico durante 7 días',
    'Tap to choose tokens or an ad': 'Toca para elegir fichas o un anuncio',
    'Do you want to unlock this named graph?':
        '¿Quieres desbloquear este gráfico?',
    'Graph name': 'Nombre del gráfico',
    'Add habit slot': 'Añadir espacio de hábito',
    'Enter a graph name.': 'Introduce un nombre para el gráfico.',
    'Choose at least one habit.': 'Elige al menos un hábito.',
    'Main custom graph with 6 habit slots':
        'Gráfico principal con 6 espacios de hábitos',
    'One named graph with a weekly 70-token unlock':
        'Un gráfico con nombre, desbloqueable por 70 fichas durante una semana',
    'Main custom graph with 10 slots; the last 4 cost 35 tokens to change':
        'Gráfico principal con 10 espacios; cambiar los últimos 4 cuesta 35 fichas',
    'Four named graphs: 2 included and 2 weekly 35-token unlocks':
        'Cuatro gráficos con nombre: 2 incluidos y 2 desbloqueables semanalmente por 35 fichas',
    'Unlimited main custom-graph habit slots':
        'Espacios ilimitados en el gráfico principal',
    'Six included named custom graphs':
        'Seis gráficos personalizados con nombre incluidos',
  },
  'ru': {
    'Named custom graphs': 'Именованные пользовательские графики',
    'Named custom graph': 'Именованный пользовательский график',
    'Create a habit group': 'Создать группу привычек',
    'Unlock this named graph for 7 days': 'Открыть этот график на 7 дней',
    'Tap to choose tokens or an ad':
        'Нажмите, чтобы выбрать жетоны или рекламу',
    'Do you want to unlock this named graph?':
        'Хотите открыть этот именованный график?',
    'Graph name': 'Название графика',
    'Add habit slot': 'Добавить место для привычки',
    'Enter a graph name.': 'Введите название графика.',
    'Choose at least one habit.': 'Выберите хотя бы одну привычку.',
    'Main custom graph with 6 habit slots':
        'Основной график с 6 местами для привычек',
    'One named graph with a weekly 70-token unlock':
        'Один именованный график с недельным открытием за 70 жетонов',
    'Main custom graph with 10 slots; the last 4 cost 35 tokens to change':
        'Основной график на 10 привычек; изменение последних 4 стоит 35 жетонов',
    'Four named graphs: 2 included and 2 weekly 35-token unlocks':
        'Четыре именованных графика: 2 включены, 2 открываются на неделю за 35 жетонов',
    'Unlimited main custom-graph habit slots':
        'Неограниченные места в основном графике',
    'Six included named custom graphs': 'Шесть включённых именованных графиков',
  },
  'fr': {
    'Named custom graphs': 'Graphiques personnalisés nommés',
    'Named custom graph': 'Graphique personnalisé nommé',
    'Create a habit group': 'Créer un groupe d’habitudes',
    'Unlock this named graph for 7 days':
        'Déverrouiller ce graphique pendant 7 jours',
    'Tap to choose tokens or an ad':
        'Touchez pour choisir des jetons ou une publicité',
    'Do you want to unlock this named graph?':
        'Voulez-vous déverrouiller ce graphique nommé ?',
    'Graph name': 'Nom du graphique',
    'Add habit slot': 'Ajouter un emplacement d’habitude',
    'Enter a graph name.': 'Saisissez un nom de graphique.',
    'Choose at least one habit.': 'Choisissez au moins une habitude.',
    'Main custom graph with 6 habit slots':
        'Graphique principal avec 6 emplacements d’habitudes',
    'One named graph with a weekly 70-token unlock':
        'Un graphique nommé déverrouillable une semaine pour 70 jetons',
    'Main custom graph with 10 slots; the last 4 cost 35 tokens to change':
        'Graphique principal à 10 emplacements ; modifier les 4 derniers coûte 35 jetons',
    'Four named graphs: 2 included and 2 weekly 35-token unlocks':
        'Quatre graphiques nommés : 2 inclus et 2 déverrouillables une semaine pour 35 jetons',
    'Unlimited main custom-graph habit slots':
        'Emplacements illimités dans le graphique principal',
    'Six included named custom graphs':
        'Six graphiques personnalisés nommés inclus',
  },
  'uz': {
    'Named custom graphs': 'Nomlangan maxsus grafiklar',
    'Named custom graph': 'Nomlangan maxsus grafik',
    'Create a habit group': 'Odatlar guruhini yaratish',
    'Unlock this named graph for 7 days': 'Bu grafikni 7 kunga ochish',
    'Tap to choose tokens or an ad':
        'Token yoki reklamani tanlash uchun bosing',
    'Do you want to unlock this named graph?':
        'Bu nomlangan grafikni ochmoqchimisiz?',
    'Graph name': 'Grafik nomi',
    'Add habit slot': 'Odat joyini qo‘shish',
    'Enter a graph name.': 'Grafik nomini kiriting.',
    'Choose at least one habit.': 'Kamida bitta odatni tanlang.',
    'Main custom graph with 6 habit slots':
        '6 ta odat joyiga ega asosiy maxsus grafik',
    'One named graph with a weekly 70-token unlock':
        'Bir haftaga 70 token bilan ochiladigan bitta nomlangan grafik',
    'Main custom graph with 10 slots; the last 4 cost 35 tokens to change':
        '10 joyli asosiy grafik; oxirgi 4 tasini o‘zgartirish 35 token',
    'Four named graphs: 2 included and 2 weekly 35-token unlocks':
        'To‘rtta nomlangan grafik: 2 tasi kiritilgan, 2 tasi haftasiga 35 token',
    'Unlimited main custom-graph habit slots':
        'Asosiy grafikda cheklanmagan odat joylari',
    'Six included named custom graphs':
        'Oltita kiritilgan nomlangan maxsus grafik',
  },
};

const Map<String, Map<String, String>> _numericalTranslations = {
  'en': {
    'Two ways to track': 'Two ways to track',
    'Thumb tracking description':
        'Thumbs save a simple daily result: did or missed for good habits, and did or avoided for unwanted habits.',
    'Numerical tracking description':
        'Numbers save today’s amount or duration and scale symbolic progress around your target. Thumbs remain available as a quick alternative.',
    'Numerical tracking': 'Numerical tracking',
    'Numerical tracking requires Plus or higher.':
        'Numerical tracking requires Plus or higher.',
    'Numerical habits': 'Numerical habits',
    'Unlimited numerical habits': 'Unlimited numerical habits',
    'Numerical tracking for up to 4 habits':
        'Numerical tracking for up to 4 habits',
    'Unlimited numerical habit tracking': 'Unlimited numerical habit tracking',
    'Use numerical tracking': 'Use numerical tracking',
    'Daily target': 'Daily target',
    'Target': 'Target',
    'On': 'On',
    'Off': 'Off',
    'glasses': 'glasses',
    'minutes': 'minutes',
    'min': 'min',
    'times': 'times',
    'Times': 'Times',
    'Hours and minutes': 'Hours and minutes',
    'hours': 'hours',
    'drinks': 'drinks',
  },
  'es': {
    'Two ways to track': 'Dos formas de registrar',
    'Thumb tracking description':
        'Los pulgares guardan un resultado diario sencillo: realizado u omitido para hábitos buenos, y realizado o evitado para hábitos no deseados.',
    'Numerical tracking description':
        'Los números guardan la cantidad o duración de hoy y ajustan el progreso simbólico según tu objetivo. Los pulgares siguen disponibles como alternativa rápida.',
    'Numerical tracking': 'Registro numérico',
    'Numerical tracking requires Plus or higher.':
        'El seguimiento numérico requiere Plus o un plan superior.',
    'Numerical habits': 'Hábitos numéricos',
    'Unlimited numerical habits': 'Hábitos numéricos ilimitados',
    'Numerical tracking for up to 4 habits':
        'Seguimiento numérico para hasta 4 hábitos',
    'Unlimited numerical habit tracking':
        'Seguimiento numérico ilimitado de hábitos',
    'Use numerical tracking': 'Usar registro numérico',
    'Daily target': 'Objetivo diario',
    'Target': 'Objetivo',
    'On': 'Activado',
    'Off': 'Desactivado',
    'glasses': 'vasos',
    'minutes': 'minutos',
    'min': 'min',
    'times': 'veces',
    'Times': 'Veces',
    'Hours and minutes': 'Horas y minutos',
    'hours': 'horas',
    'drinks': 'bebidas',
  },
  'ru': {
    'Two ways to track': 'Два способа отслеживания',
    'Thumb tracking description':
        'Кнопки с пальцами сохраняют простой итог дня: выполнено или пропущено для полезных привычек, сделано или предотвращено для нежелательных.',
    'Numerical tracking description':
        'Числа сохраняют сегодняшнее количество или длительность и меняют символический прогресс относительно цели. Кнопки с пальцами остаются быстрой альтернативой.',
    'Numerical tracking': 'Числовое отслеживание',
    'Numerical tracking requires Plus or higher.':
        'Числовое отслеживание доступно с планом Plus или выше.',
    'Numerical habits': 'Числовые привычки',
    'Unlimited numerical habits': 'Неограниченные числовые привычки',
    'Numerical tracking for up to 4 habits':
        'Числовое отслеживание до 4 привычек',
    'Unlimited numerical habit tracking':
        'Неограниченное числовое отслеживание привычек',
    'Use numerical tracking': 'Использовать числовое отслеживание',
    'Daily target': 'Дневная цель',
    'Target': 'Цель',
    'On': 'Вкл.',
    'Off': 'Выкл.',
    'glasses': 'стаканов',
    'minutes': 'минут',
    'min': 'мин',
    'times': 'раз',
    'Times': 'Раз',
    'Hours and minutes': 'Часы и минуты',
    'hours': 'часов',
    'drinks': 'порций',
  },
  'fr': {
    'Two ways to track': 'Deux modes de suivi',
    'Thumb tracking description':
        'Les pouces enregistrent un bilan quotidien simple : fait ou manqué pour les bonnes habitudes, fait ou évité pour les habitudes indésirables.',
    'Numerical tracking description':
        'Les nombres enregistrent la quantité ou la durée du jour et adaptent la progression symbolique autour de votre objectif. Les pouces restent disponibles comme option rapide.',
    'Numerical tracking': 'Suivi numérique',
    'Numerical tracking requires Plus or higher.':
        'Le suivi numérique nécessite le forfait Plus ou supérieur.',
    'Numerical habits': 'Habitudes numériques',
    'Unlimited numerical habits': 'Habitudes numériques illimitées',
    'Numerical tracking for up to 4 habits':
        'Suivi numérique pour 4 habitudes maximum',
    'Unlimited numerical habit tracking':
        'Suivi numérique illimité des habitudes',
    'Use numerical tracking': 'Utiliser le suivi numérique',
    'Daily target': 'Objectif quotidien',
    'Target': 'Objectif',
    'On': 'Activé',
    'Off': 'Désactivé',
    'glasses': 'verres',
    'minutes': 'minutes',
    'min': 'min',
    'times': 'fois',
    'Times': 'Fois',
    'Hours and minutes': 'Heures et minutes',
    'hours': 'heures',
    'drinks': 'verres',
  },
  'uz': {
    'Two ways to track': 'Kuzatishning ikki usuli',
    'Thumb tracking description':
        'Bosh barmoq tugmalari oddiy kunlik natijani saqlaydi: yaxshi odatlar uchun bajarildi yoki o‘tkazib yuborildi, nomaqbul odatlar uchun bajarildi yoki tiyilindi.',
    'Numerical tracking description':
        'Raqamlar bugungi miqdor yoki davomiylikni saqlaydi va ramziy natijani maqsadingizga qarab o‘zgartiradi. Bosh barmoq tugmalari tezkor usul sifatida qoladi.',
    'Numerical tracking': 'Raqamli kuzatish',
    'Numerical tracking requires Plus or higher.':
        'Raqamli kuzatish uchun Plus yoki undan yuqori reja kerak.',
    'Numerical habits': 'Raqamli odatlar',
    'Unlimited numerical habits': 'Cheklanmagan raqamli odatlar',
    'Numerical tracking for up to 4 habits':
        '4 tagacha odat uchun raqamli kuzatish',
    'Unlimited numerical habit tracking':
        'Odatlarni cheklanmagan raqamli kuzatish',
    'Use numerical tracking': 'Raqamli kuzatishni ishlatish',
    'Daily target': 'Kunlik maqsad',
    'Target': 'Maqsad',
    'On': 'Yoqilgan',
    'Off': 'O‘chirilgan',
    'glasses': 'stakan',
    'minutes': 'daqiqa',
    'min': 'daq',
    'times': 'marta',
    'Times': 'Marta',
    'Hours and minutes': 'Soat va daqiqa',
    'hours': 'soat',
    'drinks': 'porsiya',
  },
};

class _AppStringsDelegate extends LocalizationsDelegate<AppStrings> {
  const _AppStringsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppStrings.supportedLocales.any(
      (supported) => supported.languageCode == locale.languageCode,
    );
  }

  @override
  Future<AppStrings> load(Locale locale) async => AppStrings(locale);

  @override
  bool shouldReload(_AppStringsDelegate old) => false;
}

extension AppStringsContext on BuildContext {
  String tr(String key) => AppStrings.of(this).text(key);

  String habitAdded(String habit) => AppStrings.of(this).added(habit);
}

const Map<String, Map<String, String>> _authTranslations = {
  'en': {
    'Forgot password?': 'Forgot password?',
    'Verify reset code': 'Verify reset code',
    'Create a new password': 'Create a new password',
    'Enter your account email and we will send a six-digit reset code.':
        'Enter your account email and we will send a six-digit reset code.',
    'Enter the reset code sent to your email. It expires in 10 minutes.':
        'Enter the reset code sent to your email. It expires in 10 minutes.',
    'Choose a secure new password for your account.':
        'Choose a secure new password for your account.',
    'Send code': 'Send code',
    'Send a new code': 'Send a new code',
    'A new code was sent.': 'A new code was sent.',
    'New password': 'New password',
    'Change password': 'Change password',
    'Your password was changed. Log in with your new password.':
        'Your password was changed. Log in with your new password.',
  },
  'es': {
    'Forgot password?': '¿Olvidaste tu contraseña?',
    'Verify reset code': 'Verificar código',
    'Create a new password': 'Crear una contraseña nueva',
    'Enter your account email and we will send a six-digit reset code.':
        'Introduce el correo de tu cuenta y enviaremos un código de seis dígitos.',
    'Enter the reset code sent to your email. It expires in 10 minutes.':
        'Introduce el código enviado a tu correo. Caduca en 10 minutos.',
    'Choose a secure new password for your account.':
        'Elige una contraseña nueva y segura para tu cuenta.',
    'Send code': 'Enviar código',
    'Send a new code': 'Enviar otro código',
    'A new code was sent.': 'Se envió un código nuevo.',
    'New password': 'Contraseña nueva',
    'Change password': 'Cambiar contraseña',
    'Your password was changed. Log in with your new password.':
        'Tu contraseña se cambió. Inicia sesión con la contraseña nueva.',
  },
  'ru': {
    'Forgot password?': 'Забыли пароль?',
    'Verify reset code': 'Проверка кода',
    'Create a new password': 'Создайте новый пароль',
    'Enter your account email and we will send a six-digit reset code.':
        'Введите почту аккаунта, и мы отправим шестизначный код сброса.',
    'Enter the reset code sent to your email. It expires in 10 minutes.':
        'Введите код из письма. Он действует 10 минут.',
    'Choose a secure new password for your account.':
        'Выберите новый надёжный пароль для аккаунта.',
    'Send code': 'Отправить код',
    'Send a new code': 'Отправить новый код',
    'A new code was sent.': 'Новый код отправлен.',
    'New password': 'Новый пароль',
    'Change password': 'Изменить пароль',
    'Your password was changed. Log in with your new password.':
        'Пароль изменён. Войдите с новым паролем.',
  },
  'fr': {
    'Forgot password?': 'Mot de passe oublié ?',
    'Verify reset code': 'Vérifier le code',
    'Create a new password': 'Créer un nouveau mot de passe',
    'Enter your account email and we will send a six-digit reset code.':
        'Saisissez l’e-mail du compte et nous enverrons un code à six chiffres.',
    'Enter the reset code sent to your email. It expires in 10 minutes.':
        'Saisissez le code reçu par e-mail. Il expire dans 10 minutes.',
    'Choose a secure new password for your account.':
        'Choisissez un nouveau mot de passe sécurisé pour votre compte.',
    'Send code': 'Envoyer le code',
    'Send a new code': 'Renvoyer un code',
    'A new code was sent.': 'Un nouveau code a été envoyé.',
    'New password': 'Nouveau mot de passe',
    'Change password': 'Changer le mot de passe',
    'Your password was changed. Log in with your new password.':
        'Votre mot de passe a été modifié. Connectez-vous avec le nouveau.',
  },
  'uz': {
    'Forgot password?': 'Parolni unutdingizmi?',
    'Verify reset code': 'Kodni tasdiqlash',
    'Create a new password': 'Yangi parol yarating',
    'Enter your account email and we will send a six-digit reset code.':
        'Hisobingiz emailini kiriting, olti xonali tiklash kodini yuboramiz.',
    'Enter the reset code sent to your email. It expires in 10 minutes.':
        'Emailga yuborilgan kodni kiriting. U 10 daqiqada tugaydi.',
    'Choose a secure new password for your account.':
        'Hisobingiz uchun yangi xavfsiz parol tanlang.',
    'Send code': 'Kod yuborish',
    'Send a new code': 'Yangi kod yuborish',
    'A new code was sent.': 'Yangi kod yuborildi.',
    'New password': 'Yangi parol',
    'Change password': 'Parolni o‘zgartirish',
    'Your password was changed. Log in with your new password.':
        'Parolingiz o‘zgartirildi. Yangi parol bilan tizimga kiring.',
  },
};

const Map<String, Map<String, String>> _onboardingTranslations = {
  'en': {
    'Your profile': 'Your profile',
    'Personal details': 'Personal details',
    'What are your habits?': 'What are your habits?',
    'Choose the habits you want to track now. You can add the others later with the pen button.':
        'Choose the habits you want to track now. You can add the others later with the pen button.',
    'Select at least one habit': 'Select at least one habit',
  },
  'es': {
    'Your profile': 'Tu perfil',
    'Personal details': 'Datos personales',
    'What are your habits?': '¿Cuáles son tus hábitos?',
    'Choose the habits you want to track now. You can add the others later with the pen button.':
        'Elige los hábitos que quieres registrar ahora. Puedes añadir los demás más tarde con el botón del lápiz.',
    'Select at least one habit': 'Selecciona al menos un hábito',
  },
  'ru': {
    'Your profile': 'Ваш профиль',
    'Personal details': 'Личные данные',
    'What are your habits?': 'Какие у вас привычки?',
    'Choose the habits you want to track now. You can add the others later with the pen button.':
        'Выберите привычки, которые хотите отслеживать сейчас. Остальные можно добавить позже кнопкой с карандашом.',
    'Select at least one habit': 'Выберите хотя бы одну привычку',
  },
  'fr': {
    'Your profile': 'Votre profil',
    'Personal details': 'Informations personnelles',
    'What are your habits?': 'Quelles sont vos habitudes ?',
    'Choose the habits you want to track now. You can add the others later with the pen button.':
        'Choisissez les habitudes à suivre maintenant. Vous pourrez ajouter les autres plus tard avec le bouton crayon.',
    'Select at least one habit': 'Sélectionnez au moins une habitude',
  },
  'uz': {
    'Your profile': 'Profilingiz',
    'Personal details': 'Shaxsiy ma’lumotlar',
    'What are your habits?': 'Odatlaringiz qaysilar?',
    'Choose the habits you want to track now. You can add the others later with the pen button.':
        'Hozir kuzatmoqchi bo‘lgan odatlaringizni tanlang. Qolganlarini keyinroq qalam tugmasi orqali qo‘shishingiz mumkin.',
    'Select at least one habit': 'Kamida bitta odatni tanlang',
  },
};

const Map<String, Map<String, String>> _adTranslations = {
  'en': {
    'Watch ad': 'Watch ad',
    'Loading rewarded ad...': 'Loading rewarded ad...',
    'Watch the complete ad to receive the reward.':
        'Watch the complete ad to receive the reward.',
    'The rewarded ad is not ready. Please try again.':
        'The rewarded ad is not ready. Please try again.',
  },
  'es': {
    'Watch ad': 'Ver anuncio',
    'Loading rewarded ad...': 'Cargando anuncio recompensado...',
    'Watch the complete ad to receive the reward.':
        'Mira el anuncio completo para recibir la recompensa.',
    'The rewarded ad is not ready. Please try again.':
        'El anuncio recompensado no está listo. Inténtalo de nuevo.',
  },
  'ru': {
    'Watch ad': 'Посмотреть рекламу',
    'Loading rewarded ad...': 'Загрузка рекламы с вознаграждением...',
    'Watch the complete ad to receive the reward.':
        'Посмотрите рекламу полностью, чтобы получить награду.',
    'The rewarded ad is not ready. Please try again.':
        'Реклама с вознаграждением пока не готова. Попробуйте ещё раз.',
  },
  'fr': {
    'Watch ad': 'Regarder une publicité',
    'Loading rewarded ad...': 'Chargement de la publicité récompensée...',
    'Watch the complete ad to receive the reward.':
        'Regardez la publicité en entier pour recevoir la récompense.',
    'The rewarded ad is not ready. Please try again.':
        'La publicité récompensée n’est pas prête. Réessayez.',
  },
  'uz': {
    'Watch ad': 'Reklamani ko‘rish',
    'Loading rewarded ad...': 'Mukofotli reklama yuklanmoqda...',
    'Watch the complete ad to receive the reward.':
        'Mukofotni olish uchun reklamani oxirigacha ko‘ring.',
    'The rewarded ad is not ready. Please try again.':
        'Mukofotli reklama hali tayyor emas. Qayta urinib ko‘ring.',
  },
};

const Map<String, Map<String, String>> _newFeatureTranslations = {
  'en': {
    'Plus': 'Plus',
    'Plan': 'Plan',
    'day left': 'day left',
    'days left': 'days left',
    'Your streak calendar': 'Your streak calendar',
    'Core limited features': 'Core limited features',
    'Limited habits': 'Limited habits',
    'Limited AI usage': 'Limited AI usage',
    'On-board ads': 'On-board ads',
    'Unlimited core features': 'Unlimited core features',
    'Extended features': 'Extended features',
    'Unlimited Plus extended features': 'Unlimited Plus extended features',
    'Even more extended features': 'Even more extended features',
    'Body progress without weekly locks': 'Body progress without weekly locks',
    'Core graphs without weekly locks': 'Core graphs without weekly locks',
    'Main gradual-reduction plan without weekly locks':
        'Main gradual-reduction plan without weekly locks',
    'Full calendar history': 'Full calendar history',
    'More custom-graph slots': 'More custom-graph slots',
    'Two additional single-habit graphs': 'Two additional single-habit graphs',
    'A second gradual-reduction plan': 'A second gradual-reduction plan',
    'More habits and up to two custom habits':
        'More habits and up to two custom habits',
    'All Plus custom-graph slots without weekly locks':
        'All Plus custom-graph slots without weekly locks',
    'Two additional single-habit graphs without token or ad unlocks':
        'Two additional single-habit graphs without token or ad unlocks',
    'A second gradual-reduction plan without token or ad unlocks':
        'A second gradual-reduction plan without token or ad unlocks',
    'More and your own habits': 'More and your own habits',
    'More tokens': 'More tokens',
    'Extended AI usage': 'Extended AI usage',
    'Extended better AI usage': 'Extended better AI usage',
    'Unlimited every feature': 'Unlimited every feature',
    'Every single feature': 'Every single feature',
    'Unlimited best AI usage': 'Unlimited best AI usage',
    'Fewer on-board ads': 'Fewer on-board ads',
    'Almost no on-board ads': 'Almost no on-board ads',
    'No on-board ads': 'No on-board ads',
    'Preview Pro': 'Preview Pro',
    'Preview Ultra': 'Preview Ultra',
    'Studying': 'Studying',
    'Brushing teeth': 'Brushing teeth',
    'Skin care': 'Skin care',
    'Good sleep': 'Good sleep',
    'Meditation': 'Meditation',
    'Reading': 'Reading',
    'Consistent routine': 'Consistent routine',
    'Practising gratitude': 'Practising gratitude',
    'Productive work': 'Productive work',
    'Excessive screen time': 'Excessive screen time',
    'Excessive caffeine': 'Excessive caffeine',
    'Social media overuse': 'Social media overuse',
    'Nail biting': 'Nail biting',
    'Gaming overuse': 'Gaming overuse',
    'Create your own habit': 'Create your own habit',
    'Editing': 'Editing',
    'Custom habit limit reached': 'Custom habit limit reached',
    'Create up to 5 custom habits': 'Create up to 5 custom habits',
    'Create up to 10 custom habits': 'Create up to 10 custom habits',
    'Add organ effects to 3 custom habits':
        'Add organ effects to 3 custom habits',
    'Add organ effects to 6 custom habits':
        'Add organ effects to 6 custom habits',
    'Organ effects': 'Organ effects',
    'Edit organ effects': 'Edit organ effects',
    'Edited existing habits': 'Edited existing habits',
    'Existing-habit organ-effect limit reached':
        'Existing-habit organ-effect limit reached',
    'Customize organ effects for 2 existing habits':
        'Customize organ effects for 2 existing habits',
    'Customize organ effects for 4 existing habits':
        'Customize organ effects for 4 existing habits',
    'Range': 'Range',
    'Organ': 'Organ',
    'Mind': 'Mind',
    'Heart': 'Heart',
    'Lungs': 'Lungs',
    'Liver': 'Liver',
    'Stomach': 'Stomach',
    'Kidneys': 'Kidneys',
    'Gut': 'Gut',
    'Organ-effect habits': 'Organ-effect habits',
    'Organ-effect habit limit reached': 'Organ-effect habit limit reached',
    'Two custom habits created': 'Two custom habits created',
    'Your good habits': 'Your good habits',
    'Your unwanted habits': 'Your unwanted habits',
    'Habit name': 'Habit name',
    'Good habit': 'Good habit',
    'Unwanted habit': 'Unwanted habit',
    'Choose how you want to unlock this change.':
        'Choose how you want to unlock this change.',
    'Watch ad · coming soon': 'Watch ad · coming soon',
    'Choose token or ad': 'Choose token or ad',
    'Three-minute breathing reward added':
        'Three-minute breathing reward added',
    'Ask AI': 'Ask AI',
    'Send': 'Send',
    'Stop': 'Stop',
    'Add image': 'Add image',
    'Ask about your habits, routines, progress, or gradual-reduction plans.':
        'Ask about your habits, routines, progress, or gradual-reduction plans.',
    'How can I reduce an unwanted habit gradually?':
        'How can I reduce an unwanted habit gradually?',
    'How can I build a consistent workout routine?':
        'How can I build a consistent workout routine?',
    'How can I make drinking water easier to remember?':
        'How can I make drinking water easier to remember?',
    'What can I learn from my weekly progress?':
        'What can I learn from my weekly progress?',
    'This is a preview response. I can help you reflect on habits and build small, realistic next steps. The live AI service will be connected later, and my guidance will remain educational rather than medical advice.':
        'This is a preview response. I can help you reflect on habits and build small, realistic next steps. The live AI service will be connected later, and my guidance will remain educational rather than medical advice.',
    'New chat': 'New chat',
    'History': 'History',
    'No previous chats yet': 'No previous chats yet',
    'Image conversation': 'Image conversation',
    'Sign in to use the AI coach.': 'Sign in to use the AI coach.',
    'Could not connect to the AI coach. Check your connection and try again.':
        'Could not connect to the AI coach. Check your connection and try again.',
    'The AI coach could not complete that request.':
        'The AI coach could not complete that request.',
  },
  'es': {
    'Plus': 'Plus',
    'Plan': 'Plan',
    'day left': 'día restante',
    'days left': 'días restantes',
    'Your streak calendar': 'Tu calendario de racha',
    'Core limited features': 'Funciones básicas limitadas',
    'Limited habits': 'Hábitos limitados',
    'Limited AI usage': 'Uso limitado de IA',
    'On-board ads': 'Anuncios en la aplicación',
    'Unlimited core features': 'Funciones básicas ilimitadas',
    'Extended features': 'Funciones ampliadas',
    'Unlimited Plus extended features':
        'Funciones ampliadas de Plus sin límites',
    'Even more extended features': 'Funciones aún más ampliadas',
    'Body progress without weekly locks':
        'Progreso corporal sin bloqueos semanales',
    'Core graphs without weekly locks':
        'Gráficos principales sin bloqueos semanales',
    'Main gradual-reduction plan without weekly locks':
        'Plan principal de reducción gradual sin bloqueos semanales',
    'Full calendar history': 'Historial completo del calendario',
    'More custom-graph slots': 'Más espacios para gráficos personalizados',
    'Two additional single-habit graphs':
        'Dos gráficos adicionales de hábitos individuales',
    'A second gradual-reduction plan': 'Un segundo plan de reducción gradual',
    'More habits and up to two custom habits':
        'Más hábitos y hasta dos hábitos personalizados',
    'All Plus custom-graph slots without weekly locks':
        'Todos los espacios de gráficos personalizados de Plus sin bloqueos semanales',
    'Two additional single-habit graphs without token or ad unlocks':
        'Dos gráficos adicionales de hábitos individuales sin desbloqueos por fichas o anuncios',
    'A second gradual-reduction plan without token or ad unlocks':
        'Un segundo plan de reducción gradual sin desbloqueos por fichas o anuncios',
    'More and your own habits': 'Más hábitos y hábitos propios',
    'More tokens': 'Más fichas',
    'Extended AI usage': 'Uso ampliado de IA',
    'Extended better AI usage': 'Uso ampliado de una IA mejor',
    'Unlimited every feature': 'Todas las funciones sin límites',
    'Every single feature': 'Todas y cada una de las funciones',
    'Unlimited best AI usage': 'Uso ilimitado de la mejor IA',
    'Fewer on-board ads': 'Menos anuncios en la aplicación',
    'Almost no on-board ads': 'Casi sin anuncios en la aplicación',
    'No on-board ads': 'Sin anuncios dentro de la aplicación',
    'Preview Pro': 'Probar Pro',
    'Preview Ultra': 'Probar Ultra',
    'Studying': 'Estudiar',
    'Brushing teeth': 'Cepillarse los dientes',
    'Skin care': 'Cuidado de la piel',
    'Good sleep': 'Buen descanso',
    'Meditation': 'Meditación',
    'Reading': 'Lectura',
    'Consistent routine': 'Rutina constante',
    'Practising gratitude': 'Practicar la gratitud',
    'Productive work': 'Trabajo productivo',
    'Excessive screen time': 'Tiempo de pantalla excesivo',
    'Excessive caffeine': 'Consumo excesivo de cafeína',
    'Social media overuse': 'Uso excesivo de redes sociales',
    'Nail biting': 'Morderse las uñas',
    'Gaming overuse': 'Uso excesivo de videojuegos',
    'Create your own habit': 'Crea tu propio hábito',
    'Editing': 'Editando',
    'Custom habit limit reached':
        'Se alcanzó el límite de hábitos personalizados',
    'Create up to 5 custom habits': 'Crea hasta 5 hábitos personalizados',
    'Create up to 10 custom habits': 'Crea hasta 10 hábitos personalizados',
    'Add organ effects to 3 custom habits':
        'Añade efectos en órganos a 3 hábitos personalizados',
    'Add organ effects to 6 custom habits':
        'Añade efectos en órganos a 6 hábitos personalizados',
    'Organ effects': 'Efectos en órganos',
    'Edit organ effects': 'Editar efectos en órganos',
    'Edited existing habits': 'Hábitos existentes editados',
    'Existing-habit organ-effect limit reached':
        'Se alcanzó el límite de efectos para hábitos existentes',
    'Customize organ effects for 2 existing habits':
        'Personaliza los efectos en órganos de 2 hábitos existentes',
    'Customize organ effects for 4 existing habits':
        'Personaliza los efectos en órganos de 4 hábitos existentes',
    'Range': 'Rango',
    'Organ': 'Órgano',
    'Mind': 'Mente',
    'Heart': 'Corazón',
    'Lungs': 'Pulmones',
    'Liver': 'Hígado',
    'Stomach': 'Estómago',
    'Kidneys': 'Riñones',
    'Gut': 'Intestino',
    'Organ-effect habits': 'Hábitos con efectos en órganos',
    'Organ-effect habit limit reached':
        'Se alcanzó el límite de hábitos con efectos en órganos',
    'Two custom habits created': 'Dos hábitos personalizados creados',
    'Your good habits': 'Tus buenos hábitos',
    'Your unwanted habits': 'Tus hábitos no deseados',
    'Habit name': 'Nombre del hábito',
    'Good habit': 'Buen hábito',
    'Unwanted habit': 'Hábito no deseado',
    'Choose how you want to unlock this change.':
        'Elige cómo quieres desbloquear este cambio.',
    'Watch ad · coming soon': 'Ver anuncio · próximamente',
    'Choose token or ad': 'Elegir fichas o anuncio',
    'Three-minute breathing reward added':
        'Recompensa de respiración de tres minutos añadida',
    'Ask AI': 'Preguntar a la IA',
    'Send': 'Enviar',
    'Stop': 'Detener',
    'Add image': 'Añadir imagen',
    'Ask about your habits, routines, progress, or gradual-reduction plans.':
        'Pregunta sobre tus hábitos, rutinas, progreso o planes de reducción gradual.',
    'How can I reduce an unwanted habit gradually?':
        '¿Cómo puedo reducir gradualmente un hábito no deseado?',
    'How can I build a consistent workout routine?':
        '¿Cómo puedo crear una rutina de ejercicio constante?',
    'How can I make drinking water easier to remember?':
        '¿Cómo puedo recordar más fácilmente beber agua?',
    'What can I learn from my weekly progress?':
        '¿Qué puedo aprender de mi progreso semanal?',
    'This is a preview response. I can help you reflect on habits and build small, realistic next steps. The live AI service will be connected later, and my guidance will remain educational rather than medical advice.':
        'Esta es una respuesta de vista previa. Puedo ayudarte a reflexionar sobre tus hábitos y crear próximos pasos pequeños y realistas. El servicio de IA se conectará más adelante y la orientación seguirá siendo educativa, no un consejo médico.',
    'New chat': 'Nuevo chat',
    'History': 'Historial',
    'No previous chats yet': 'Aún no hay chats anteriores',
    'Image conversation': 'Conversación con imagen',
    'Sign in to use the AI coach.':
        'Inicia sesión para usar el entrenador de IA.',
    'Could not connect to the AI coach. Check your connection and try again.':
        'No se pudo conectar con el entrenador de IA. Comprueba tu conexión e inténtalo de nuevo.',
    'The AI coach could not complete that request.':
        'El entrenador de IA no pudo completar esa solicitud.',
  },
  'ru': {
    'Plus': 'Plus',
    'Plan': 'План',
    'day left': 'день остался',
    'days left': 'дней осталось',
    'Your streak calendar': 'Календарь серии',
    'Core limited features': 'Ограниченные основные функции',
    'Limited habits': 'Ограниченное число привычек',
    'Limited AI usage': 'Ограниченное использование ИИ',
    'On-board ads': 'Реклама в приложении',
    'Unlimited core features': 'Основные функции без ограничений',
    'Extended features': 'Расширенные функции',
    'Unlimited Plus extended features':
        'Расширенные функции Plus без ограничений',
    'Even more extended features': 'Ещё больше расширенных функций',
    'Body progress without weekly locks':
        'Прогресс тела без еженедельной блокировки',
    'Core graphs without weekly locks':
        'Основные графики без еженедельной блокировки',
    'Main gradual-reduction plan without weekly locks':
        'Основной план постепенного отказа без еженедельной блокировки',
    'Full calendar history': 'Полная история календаря',
    'More custom-graph slots': 'Больше слотов для пользовательских графиков',
    'Two additional single-habit graphs':
        'Два дополнительных графика отдельных привычек',
    'A second gradual-reduction plan': 'Второй план постепенного отказа',
    'More habits and up to two custom habits':
        'Больше привычек и до двух собственных привычек',
    'All Plus custom-graph slots without weekly locks':
        'Все слоты пользовательских графиков Plus без еженедельной блокировки',
    'Two additional single-habit graphs without token or ad unlocks':
        'Два дополнительных графика отдельных привычек без разблокировки за жетоны или рекламу',
    'A second gradual-reduction plan without token or ad unlocks':
        'Второй план постепенного отказа без разблокировки за жетоны или рекламу',
    'More and your own habits': 'Больше привычек и свои привычки',
    'More tokens': 'Больше жетонов',
    'Extended AI usage': 'Расширенное использование ИИ',
    'Extended better AI usage': 'Расширенное использование улучшенного ИИ',
    'Unlimited every feature': 'Все функции без ограничений',
    'Every single feature': 'Все до единой функции',
    'Unlimited best AI usage': 'Неограниченное использование лучшего ИИ',
    'Fewer on-board ads': 'Меньше рекламы в приложении',
    'Almost no on-board ads': 'Почти без рекламы в приложении',
    'No on-board ads': 'Без рекламы в приложении',
    'Preview Pro': 'Попробовать Pro',
    'Preview Ultra': 'Попробовать Ultra',
    'Studying': 'Учёба',
    'Brushing teeth': 'Чистка зубов',
    'Skin care': 'Уход за кожей',
    'Good sleep': 'Хороший сон',
    'Meditation': 'Медитация',
    'Reading': 'Чтение',
    'Consistent routine': 'Постоянный распорядок',
    'Practising gratitude': 'Практика благодарности',
    'Productive work': 'Продуктивная работа',
    'Excessive screen time': 'Чрезмерное экранное время',
    'Excessive caffeine': 'Чрезмерное употребление кофеина',
    'Social media overuse': 'Чрезмерное использование соцсетей',
    'Nail biting': 'Обкусывание ногтей',
    'Gaming overuse': 'Чрезмерное увлечение играми',
    'Create your own habit': 'Создать свою привычку',
    'Editing': 'Редактирование',
    'Custom habit limit reached': 'Достигнут лимит собственных привычек',
    'Create up to 5 custom habits': 'Создавайте до 5 собственных привычек',
    'Create up to 10 custom habits': 'Создавайте до 10 собственных привычек',
    'Add organ effects to 3 custom habits':
        'Добавьте влияние на органы для 3 собственных привычек',
    'Add organ effects to 6 custom habits':
        'Добавьте влияние на органы для 6 собственных привычек',
    'Organ effects': 'Влияние на органы',
    'Edit organ effects': 'Изменить влияние на органы',
    'Edited existing habits': 'Изменённые существующие привычки',
    'Existing-habit organ-effect limit reached':
        'Достигнут лимит влияния для существующих привычек',
    'Customize organ effects for 2 existing habits':
        'Настройте влияние на органы для 2 существующих привычек',
    'Customize organ effects for 4 existing habits':
        'Настройте влияние на органы для 4 существующих привычек',
    'Range': 'Диапазон',
    'Organ': 'Орган',
    'Mind': 'Разум',
    'Heart': 'Сердце',
    'Lungs': 'Лёгкие',
    'Liver': 'Печень',
    'Stomach': 'Желудок',
    'Kidneys': 'Почки',
    'Gut': 'Кишечник',
    'Organ-effect habits': 'Привычки с влиянием на органы',
    'Organ-effect habit limit reached':
        'Достигнут лимит привычек с влиянием на органы',
    'Two custom habits created': 'Созданы две свои привычки',
    'Your good habits': 'Ваши полезные привычки',
    'Your unwanted habits': 'Ваши нежелательные привычки',
    'Habit name': 'Название привычки',
    'Good habit': 'Полезная привычка',
    'Unwanted habit': 'Нежелательная привычка',
    'Choose how you want to unlock this change.':
        'Выберите способ разблокировки изменения.',
    'Watch ad · coming soon': 'Посмотреть рекламу · скоро',
    'Choose token or ad': 'Выбрать жетоны или рекламу',
    'Three-minute breathing reward added':
        'Награда за три минуты дыхания добавлена',
    'Ask AI': 'Спросить ИИ',
    'Send': 'Отправить',
    'Stop': 'Остановить',
    'Add image': 'Добавить изображение',
    'Ask about your habits, routines, progress, or gradual-reduction plans.':
        'Спросите о привычках, распорядке, прогрессе или планах постепенного сокращения.',
    'How can I reduce an unwanted habit gradually?':
        'Как постепенно сократить нежелательную привычку?',
    'How can I build a consistent workout routine?':
        'Как выработать постоянный режим тренировок?',
    'How can I make drinking water easier to remember?':
        'Как легче не забывать пить воду?',
    'What can I learn from my weekly progress?':
        'Что можно узнать из моего недельного прогресса?',
    'This is a preview response. I can help you reflect on habits and build small, realistic next steps. The live AI service will be connected later, and my guidance will remain educational rather than medical advice.':
        'Это предварительный ответ. Я могу помочь проанализировать привычки и выбрать небольшие реалистичные следующие шаги. Сервис ИИ будет подключён позже, а рекомендации останутся образовательными и не будут медицинской консультацией.',
    'New chat': 'Новый чат',
    'History': 'История',
    'No previous chats yet': 'Предыдущих чатов пока нет',
    'Image conversation': 'Разговор с изображением',
    'Sign in to use the AI coach.': 'Войдите, чтобы использовать ИИ-тренера.',
    'Could not connect to the AI coach. Check your connection and try again.':
        'Не удалось подключиться к ИИ-тренеру. Проверьте соединение и повторите попытку.',
    'The AI coach could not complete that request.':
        'ИИ-тренеру не удалось выполнить этот запрос.',
  },
  'fr': {
    'Plus': 'Plus',
    'Plan': 'Offre',
    'day left': 'jour restant',
    'days left': 'jours restants',
    'Your streak calendar': 'Votre calendrier de série',
    'Core limited features': 'Fonctions essentielles limitées',
    'Limited habits': 'Habitudes limitées',
    'Limited AI usage': 'Utilisation limitée de l’IA',
    'On-board ads': 'Publicités dans l’application',
    'Unlimited core features': 'Fonctions essentielles illimitées',
    'Extended features': 'Fonctions étendues',
    'Unlimited Plus extended features': 'Fonctions étendues de Plus illimitées',
    'Even more extended features': 'Fonctions encore plus étendues',
    'Body progress without weekly locks':
        'Progression du corps sans blocage hebdomadaire',
    'Core graphs without weekly locks':
        'Graphiques principaux sans blocage hebdomadaire',
    'Main gradual-reduction plan without weekly locks':
        'Plan principal de réduction progressive sans blocage hebdomadaire',
    'Full calendar history': 'Historique complet du calendrier',
    'More custom-graph slots':
        'Plus d’emplacements de graphiques personnalisés',
    'Two additional single-habit graphs':
        'Deux graphiques supplémentaires pour une habitude',
    'A second gradual-reduction plan':
        'Un second plan de réduction progressive',
    'More habits and up to two custom habits':
        'Plus d’habitudes et jusqu’à deux habitudes personnalisées',
    'All Plus custom-graph slots without weekly locks':
        'Tous les emplacements de graphiques personnalisés Plus sans blocage hebdomadaire',
    'Two additional single-habit graphs without token or ad unlocks':
        'Deux graphiques supplémentaires pour une habitude sans déblocage par jetons ou publicité',
    'A second gradual-reduction plan without token or ad unlocks':
        'Un second plan de réduction progressive sans déblocage par jetons ou publicité',
    'More and your own habits': 'Plus d’habitudes et vos propres habitudes',
    'More tokens': 'Plus de jetons',
    'Extended AI usage': 'Utilisation étendue de l’IA',
    'Extended better AI usage': 'Utilisation étendue d’une meilleure IA',
    'Unlimited every feature': 'Toutes les fonctionnalités sans limites',
    'Every single feature': 'Toutes les fonctionnalités sans exception',
    'Unlimited best AI usage': 'Utilisation illimitée de la meilleure IA',
    'Fewer on-board ads': 'Moins de publicités dans l’application',
    'Almost no on-board ads': 'Presque aucune publicité dans l’application',
    'No on-board ads': 'Aucune publicité dans l’application',
    'Preview Pro': 'Essayer Pro',
    'Preview Ultra': 'Essayer Ultra',
    'Studying': 'Étudier',
    'Brushing teeth': 'Brossage des dents',
    'Skin care': 'Soins de la peau',
    'Good sleep': 'Bon sommeil',
    'Meditation': 'Méditation',
    'Reading': 'Lecture',
    'Consistent routine': 'Routine régulière',
    'Practising gratitude': 'Pratiquer la gratitude',
    'Productive work': 'Travail productif',
    'Excessive screen time': 'Temps d’écran excessif',
    'Excessive caffeine': 'Consommation excessive de caféine',
    'Social media overuse': 'Utilisation excessive des réseaux sociaux',
    'Nail biting': 'Se ronger les ongles',
    'Gaming overuse': 'Usage excessif des jeux vidéo',
    'Create your own habit': 'Créer votre propre habitude',
    'Editing': 'Modification',
    'Custom habit limit reached': 'Limite d’habitudes personnalisées atteinte',
    'Create up to 5 custom habits': 'Créez jusqu’à 5 habitudes personnalisées',
    'Create up to 10 custom habits':
        'Créez jusqu’à 10 habitudes personnalisées',
    'Add organ effects to 3 custom habits':
        'Ajoutez des effets sur les organes à 3 habitudes personnalisées',
    'Add organ effects to 6 custom habits':
        'Ajoutez des effets sur les organes à 6 habitudes personnalisées',
    'Organ effects': 'Effets sur les organes',
    'Edit organ effects': 'Modifier les effets sur les organes',
    'Edited existing habits': 'Habitudes existantes modifiées',
    'Existing-habit organ-effect limit reached':
        'Limite d’effets pour les habitudes existantes atteinte',
    'Customize organ effects for 2 existing habits':
        'Personnalisez les effets de 2 habitudes existantes',
    'Customize organ effects for 4 existing habits':
        'Personnalisez les effets de 4 habitudes existantes',
    'Range': 'Plage',
    'Organ': 'Organe',
    'Mind': 'Esprit',
    'Heart': 'Cœur',
    'Lungs': 'Poumons',
    'Liver': 'Foie',
    'Stomach': 'Estomac',
    'Kidneys': 'Reins',
    'Gut': 'Intestin',
    'Organ-effect habits': 'Habitudes affectant les organes',
    'Organ-effect habit limit reached':
        'Limite d’habitudes affectant les organes atteinte',
    'Two custom habits created': 'Deux habitudes personnalisées créées',
    'Your good habits': 'Vos bonnes habitudes',
    'Your unwanted habits': 'Vos habitudes indésirables',
    'Habit name': 'Nom de l’habitude',
    'Good habit': 'Bonne habitude',
    'Unwanted habit': 'Habitude indésirable',
    'Choose how you want to unlock this change.':
        'Choisissez comment débloquer cette modification.',
    'Watch ad · coming soon': 'Regarder une publicité · bientôt',
    'Choose token or ad': 'Choisir jetons ou publicité',
    'Three-minute breathing reward added':
        'Récompense de respiration de trois minutes ajoutée',
    'Ask AI': 'Demander à l’IA',
    'Send': 'Envoyer',
    'Stop': 'Arrêter',
    'Add image': 'Ajouter une image',
    'Ask about your habits, routines, progress, or gradual-reduction plans.':
        'Posez vos questions sur vos habitudes, routines, progrès ou plans de réduction progressive.',
    'How can I reduce an unwanted habit gradually?':
        'Comment réduire progressivement une habitude indésirable ?',
    'How can I build a consistent workout routine?':
        'Comment créer une routine sportive régulière ?',
    'How can I make drinking water easier to remember?':
        'Comment penser plus facilement à boire de l’eau ?',
    'What can I learn from my weekly progress?':
        'Que puis-je apprendre de mes progrès hebdomadaires ?',
    'This is a preview response. I can help you reflect on habits and build small, realistic next steps. The live AI service will be connected later, and my guidance will remain educational rather than medical advice.':
        'Ceci est une réponse d’aperçu. Je peux vous aider à réfléchir à vos habitudes et à définir de petites étapes réalistes. Le service d’IA sera connecté plus tard et mes conseils resteront éducatifs, sans constituer un avis médical.',
    'New chat': 'Nouvelle discussion',
    'History': 'Historique',
    'No previous chats yet': 'Aucune discussion précédente',
    'Image conversation': 'Discussion avec image',
    'Sign in to use the AI coach.': 'Connectez-vous pour utiliser le coach IA.',
    'Could not connect to the AI coach. Check your connection and try again.':
        'Impossible de se connecter au coach IA. Vérifiez votre connexion et réessayez.',
    'The AI coach could not complete that request.':
        'Le coach IA n’a pas pu traiter cette demande.',
  },
  'uz': {
    'Plus': 'Plus',
    'Plan': 'Tarif',
    'day left': 'kun qoldi',
    'days left': 'kun qoldi',
    'Your streak calendar': 'Ketma-ketlik taqvimi',
    'Core limited features': 'Cheklangan asosiy imkoniyatlar',
    'Limited habits': 'Cheklangan odatlar',
    'Limited AI usage': 'Cheklangan AI ishlatish',
    'On-board ads': 'Ilova ichidagi reklamalar',
    'Unlimited core features': 'Cheklanmagan asosiy imkoniyatlar',
    'Extended features': 'Kengaytirilgan imkoniyatlar',
    'Unlimited Plus extended features':
        'Plus kengaytirilgan imkoniyatlari cheklanmagan',
    'Even more extended features': 'Yanada kengaytirilgan imkoniyatlar',
    'Body progress without weekly locks': 'Tana rivoji haftalik bloklarsiz',
    'Core graphs without weekly locks': 'Asosiy grafiklar haftalik bloklarsiz',
    'Main gradual-reduction plan without weekly locks':
        'Asosiy bosqichma-bosqich kamaytirish rejasi haftalik bloklarsiz',
    'Full calendar history': 'To‘liq taqvim tarixi',
    'More custom-graph slots': 'Maxsus grafiklar uchun ko‘proq joy',
    'Two additional single-habit graphs':
        'Yakka odat uchun ikkita qo‘shimcha grafik',
    'A second gradual-reduction plan':
        'Ikkinchi bosqichma-bosqich kamaytirish rejasi',
    'More habits and up to two custom habits':
        'Ko‘proq odatlar va ikkitagacha shaxsiy odat',
    'All Plus custom-graph slots without weekly locks':
        'Plus maxsus grafik joylarining barchasi haftalik bloklarsiz',
    'Two additional single-habit graphs without token or ad unlocks':
        'Yakka odat uchun ikkita qo‘shimcha grafik token yoki reklama orqali ochishsiz',
    'A second gradual-reduction plan without token or ad unlocks':
        'Ikkinchi bosqichma-bosqich kamaytirish rejasi token yoki reklama orqali ochishsiz',
    'More and your own habits': 'Ko‘proq va o‘zingizning odatlaringiz',
    'More tokens': 'Ko‘proq tokenlar',
    'Extended AI usage': 'Kengaytirilgan AI ishlatish',
    'Extended better AI usage': 'Yaxshiroq AIdan kengaytirilgan foydalanish',
    'Unlimited every feature': 'Barcha imkoniyatlar cheklanmagan',
    'Every single feature': 'Har bir imkoniyat',
    'Unlimited best AI usage': 'Eng yaxshi AIdan cheksiz foydalanish',
    'Fewer on-board ads': 'Kamroq ilova ichidagi reklama',
    'Almost no on-board ads': 'Ilovada deyarli reklamasiz',
    'No on-board ads': 'Ilova ichida reklamasiz',
    'Preview Pro': 'Pro tarifini sinash',
    'Preview Ultra': 'Ultra tarifini sinash',
    'Studying': 'O‘qish',
    'Brushing teeth': 'Tishlarni tozalash',
    'Skin care': 'Teri parvarishi',
    'Good sleep': 'Yaxshi uyqu',
    'Meditation': 'Meditatsiya',
    'Reading': 'Kitob o‘qish',
    'Consistent routine': 'Izchil tartib',
    'Practising gratitude': 'Minnatdorlikni mashq qilish',
    'Productive work': 'Samarali ishlash',
    'Excessive screen time': 'Haddan tashqari ekran vaqti',
    'Excessive caffeine': 'Haddan tashqari kofein iste’moli',
    'Social media overuse': 'Ijtimoiy tarmoqlardan ortiqcha foydalanish',
    'Nail biting': 'Tirnoq tishlash',
    'Gaming overuse': 'O‘yinlardan ortiqcha foydalanish',
    'Create your own habit': 'O‘z odatingizni yarating',
    'Editing': 'Tahrirlash',
    'Custom habit limit reached': 'Shaxsiy odatlar chegarasiga yetildi',
    'Create up to 5 custom habits': '5 tagacha shaxsiy odat yarating',
    'Create up to 10 custom habits': '10 tagacha shaxsiy odat yarating',
    'Add organ effects to 3 custom habits':
        '3 ta shaxsiy odatga organ ta’sirlarini qo‘shing',
    'Add organ effects to 6 custom habits':
        '6 ta shaxsiy odatga organ ta’sirlarini qo‘shing',
    'Organ effects': 'Organlarga ta’siri',
    'Edit organ effects': 'Organ ta’sirlarini tahrirlash',
    'Edited existing habits': 'Tahrirlangan mavjud odatlar',
    'Existing-habit organ-effect limit reached':
        'Mavjud odatlar uchun organ ta’siri chegarasiga yetildi',
    'Customize organ effects for 2 existing habits':
        '2 ta mavjud odatning organ ta’sirlarini sozlang',
    'Customize organ effects for 4 existing habits':
        '4 ta mavjud odatning organ ta’sirlarini sozlang',
    'Range': 'Oraliq',
    'Organ': 'Organ',
    'Mind': 'Ong',
    'Heart': 'Yurak',
    'Lungs': 'O‘pka',
    'Liver': 'Jigar',
    'Stomach': 'Oshqozon',
    'Kidneys': 'Buyraklar',
    'Gut': 'Ichak',
    'Organ-effect habits': 'Organlarga ta’sir qiluvchi odatlar',
    'Organ-effect habit limit reached':
        'Organlarga ta’sir qiluvchi odatlar chegarasiga yetildi',
    'Two custom habits created': 'Ikkita maxsus odat yaratildi',
    'Your good habits': 'Yaxshi odatlaringiz',
    'Your unwanted habits': 'Keraksiz odatlaringiz',
    'Habit name': 'Odat nomi',
    'Good habit': 'Yaxshi odat',
    'Unwanted habit': 'Keraksiz odat',
    'Choose how you want to unlock this change.':
        'Bu o‘zgarishni qanday ochishni tanlang.',
    'Watch ad · coming soon': 'Reklama ko‘rish · tez orada',
    'Choose token or ad': 'Token yoki reklamani tanlang',
    'Three-minute breathing reward added':
        'Uch daqiqalik nafas mukofoti qo‘shildi',
    'Ask AI': 'AI’dan so‘rang',
    'Send': 'Yuborish',
    'Stop': 'To‘xtatish',
    'Add image': 'Rasm qo‘shish',
    'Ask about your habits, routines, progress, or gradual-reduction plans.':
        'Odatlaringiz, kun tartibingiz, rivojlanishingiz yoki bosqichma-bosqich kamaytirish rejalari haqida so‘rang.',
    'How can I reduce an unwanted habit gradually?':
        'Keraksiz odatni qanday qilib asta-sekin kamaytirishim mumkin?',
    'How can I build a consistent workout routine?':
        'Qanday qilib muntazam mashq qilish tartibini yaratsam bo‘ladi?',
    'How can I make drinking water easier to remember?':
        'Suv ichishni eslab qolishni qanday osonlashtirsam bo‘ladi?',
    'What can I learn from my weekly progress?':
        'Haftalik rivojlanishimdan nimalarni bilib olishim mumkin?',
    'This is a preview response. I can help you reflect on habits and build small, realistic next steps. The live AI service will be connected later, and my guidance will remain educational rather than medical advice.':
        'Bu sinov javobi. Men odatlaringizni tahlil qilishga va kichik, amalga oshirish mumkin bo‘lgan keyingi qadamlarni tanlashga yordam beraman. Jonli AI xizmati keyinroq ulanadi va tavsiyalarim tibbiy maslahat emas, faqat ma’rifiy yo‘nalishda bo‘ladi.',
    'New chat': 'Yangi chat',
    'History': 'Tarix',
    'No previous chats yet': 'Hozircha oldingi chatlar yo‘q',
    'Image conversation': 'Rasmli suhbat',
    'Sign in to use the AI coach.':
        'AI murabbiydan foydalanish uchun tizimga kiring.',
    'Could not connect to the AI coach. Check your connection and try again.':
        'AI murabbiyga ulanib bo‘lmadi. Internet aloqangizni tekshirib, qayta urinib ko‘ring.',
    'The AI coach could not complete that request.':
        'AI murabbiy bu so‘rovni bajara olmadi.',
  },
};

const Map<String, Map<String, String>> _rewardTranslations = {
  'en': {
    'Visual You Plus': 'Visual You Plus',
    'Choose your plan': 'Choose your plan',
    'Build your best Visual You': 'Build your best Visual You',
    'Choose the plan that fits your journey. You can change it later.':
        'Choose the plan that fits your journey. You can change it later.',
    'Free': 'Free',
    'Current plan': 'Current plan',
    'Switch to Free': 'Switch to Free',
    'Preview Plus': 'Preview Plus',
    'Core habit tracking': 'Core habit tracking',
    '3 habits in the custom graph': '3 habits in the custom graph',
    '2 special habit graphs': '2 special habit graphs',
    '1 gradual-reduction calendar': '1 gradual-reduction calendar',
    'Weekly token unlocks': 'Weekly token unlocks',
    'Everything in Free': 'Everything in Free',
    'High sugar consumption tracking': 'High sugar consumption tracking',
    '6 habits in the custom graph': '6 habits in the custom graph',
    '4 special habit graphs': '4 special habit graphs',
    '2 gradual-reduction calendars': '2 gradual-reduction calendars',
    'All weekly feature locks removed': 'All weekly feature locks removed',
    '70 bonus tokens every month': '70 bonus tokens every month',
    'Future premium integrations': 'Future premium integrations',
    'This is a local preview. Store billing will be connected before release.':
        'This is a local preview. Store billing will be connected before release.',
    'Streak': 'Streak',
    'Tokens': 'Tokens',
    'Aid': 'Aid',
    'Badges': 'Badges',
    'Buy streak aid?': 'Buy streak aid?',
    'One aid protects an active streak through up to two consecutive missed days.':
        'One aid protects an active streak through up to two consecutive missed days.',
    'Streak aid added.': 'Streak aid added.',
    'You need 35 tokens for a streak aid.':
        'You need 35 tokens for a streak aid.',
    'Your streak path': 'Your streak path',
    'Bronze badges': 'Bronze badges',
    'Profile': 'Profile',
    'Body': 'Body',
    'Unlock for 7 days': 'Unlock for 7 days',
    'Use 70 tokens': 'Use 70 tokens',
    'Not enough tokens': 'Not enough tokens',
    'Visual body': 'Visual body',
    'Progress graphs': 'Progress graphs',
    'Gradual-reduction calendar': 'Gradual-reduction calendar',
    'Use 35 tokens': 'Use 35 tokens',
    'Choose up to': 'Choose up to',
    'habits and set their point values.': 'habits and set their point values.',
  },
  'es': {
    'Visual You Plus': 'Visual You Plus',
    'Choose your plan': 'Elige tu plan',
    'Build your best Visual You': 'Construye tu mejor Visual You',
    'Choose the plan that fits your journey. You can change it later.':
        'Elige el plan que se adapte a tu camino. Puedes cambiarlo después.',
    'Free': 'Gratis',
    'Current plan': 'Plan actual',
    'Switch to Free': 'Cambiar a Gratis',
    'Preview Plus': 'Probar Plus',
    'Core habit tracking': 'Seguimiento básico de hábitos',
    '3 habits in the custom graph': '3 hábitos en el gráfico personalizado',
    '2 special habit graphs': '2 gráficos especiales',
    '1 gradual-reduction calendar': '1 calendario de reducción gradual',
    'Weekly token unlocks': 'Desbloqueos semanales con fichas',
    'Everything in Free': 'Todo lo de Gratis',
    'High sugar consumption tracking': 'Seguimiento del consumo alto de azúcar',
    '6 habits in the custom graph': '6 hábitos en el gráfico personalizado',
    '4 special habit graphs': '4 gráficos especiales',
    '2 gradual-reduction calendars': '2 calendarios de reducción gradual',
    'All weekly feature locks removed': 'Sin bloqueos semanales',
    '70 bonus tokens every month': '70 fichas extra cada mes',
    'Future premium integrations': 'Futuras integraciones prémium',
    'This is a local preview. Store billing will be connected before release.':
        'Esta es una vista previa local. Los pagos de la tienda se conectarán antes del lanzamiento.',
    'Streak': 'Racha',
    'Tokens': 'Fichas',
    'Badges': 'Insignias',
    'Your streak path': 'Tu camino de racha',
    'Bronze badges': 'Insignias de bronce',
    'Profile': 'Perfil',
    'Body': 'Cuerpo',
    'Unlock for 7 days': 'Desbloquear por 7 días',
    'Use 70 tokens': 'Usar 70 fichas',
    'Not enough tokens': 'No tienes suficientes fichas',
    'Visual body': 'Cuerpo visual',
    'Progress graphs': 'Gráficos de progreso',
    'Gradual-reduction calendar': 'Calendario de reducción gradual',
    'Use 35 tokens': 'Usar 35 fichas',
    'Choose up to': 'Elige hasta',
    'habits and set their point values.': 'hábitos y define sus puntos.',
  },
  'ru': {
    'Visual You Plus': 'Visual You Plus',
    'Choose your plan': 'Выберите план',
    'Build your best Visual You': 'Создайте лучшую версию себя',
    'Choose the plan that fits your journey. You can change it later.':
        'Выберите подходящий план. Его можно изменить позже.',
    'Free': 'Бесплатно',
    'Current plan': 'Текущий план',
    'Switch to Free': 'Перейти на бесплатный',
    'Preview Plus': 'Попробовать Plus',
    'Core habit tracking': 'Основное отслеживание привычек',
    '3 habits in the custom graph': '3 привычки в своём графике',
    '2 special habit graphs': '2 специальных графика',
    '1 gradual-reduction calendar': '1 календарь постепенного сокращения',
    'Weekly token unlocks': 'Еженедельная разблокировка за жетоны',
    'Everything in Free': 'Всё из бесплатного плана',
    'High sugar consumption tracking':
        'Отслеживание высокого потребления сахара',
    '6 habits in the custom graph': '6 привычек в своём графике',
    '4 special habit graphs': '4 специальных графика',
    '2 gradual-reduction calendars': '2 календаря постепенного сокращения',
    'All weekly feature locks removed': 'Без еженедельных блокировок',
    '70 bonus tokens every month': '70 бонусных жетонов каждый месяц',
    'Future premium integrations': 'Будущие премиум-интеграции',
    'This is a local preview. Store billing will be connected before release.':
        'Это локальный предпросмотр. Оплата через магазин будет подключена до выпуска.',
    'Streak': 'Серия',
    'Tokens': 'Жетоны',
    'Badges': 'Значки',
    'Your streak path': 'Путь серии',
    'Bronze badges': 'Бронзовые значки',
    'Profile': 'Профиль',
    'Body': 'Тело',
    'Unlock for 7 days': 'Открыть на 7 дней',
    'Use 70 tokens': 'Использовать 70 жетонов',
    'Not enough tokens': 'Недостаточно жетонов',
    'Visual body': 'Визуальное тело',
    'Progress graphs': 'Графики прогресса',
    'Gradual-reduction calendar': 'Календарь постепенного сокращения',
    'Use 35 tokens': 'Использовать 35 жетонов',
    'Choose up to': 'Выберите до',
    'habits and set their point values.': 'привычек и задайте их баллы.',
  },
  'fr': {
    'Visual You Plus': 'Visual You Plus',
    'Choose your plan': 'Choisissez votre offre',
    'Build your best Visual You': 'Construisez votre meilleur Visual You',
    'Choose the plan that fits your journey. You can change it later.':
        'Choisissez l’offre adaptée à votre parcours. Vous pourrez la modifier plus tard.',
    'Free': 'Gratuit',
    'Current plan': 'Offre actuelle',
    'Switch to Free': 'Passer au gratuit',
    'Preview Plus': 'Essayer Plus',
    'Core habit tracking': 'Suivi essentiel des habitudes',
    '3 habits in the custom graph':
        '3 habitudes dans le graphique personnalisé',
    '2 special habit graphs': '2 graphiques spéciaux',
    '1 gradual-reduction calendar': '1 calendrier de réduction progressive',
    'Weekly token unlocks': 'Déblocages hebdomadaires avec des jetons',
    'Everything in Free': 'Tout le contenu Gratuit',
    'High sugar consumption tracking':
        'Suivi de la forte consommation de sucre',
    '6 habits in the custom graph':
        '6 habitudes dans le graphique personnalisé',
    '4 special habit graphs': '4 graphiques spéciaux',
    '2 gradual-reduction calendars': '2 calendriers de réduction progressive',
    'All weekly feature locks removed': 'Aucun verrouillage hebdomadaire',
    '70 bonus tokens every month': '70 jetons bonus chaque mois',
    'Future premium integrations': 'Futures intégrations premium',
    'This is a local preview. Store billing will be connected before release.':
        'Ceci est un aperçu local. Le paiement de la boutique sera connecté avant la sortie.',
    'Streak': 'Série',
    'Tokens': 'Jetons',
    'Badges': 'Badges',
    'Your streak path': 'Votre parcours de série',
    'Bronze badges': 'Badges de bronze',
    'Profile': 'Profil',
    'Body': 'Corps',
    'Unlock for 7 days': 'Débloquer pendant 7 jours',
    'Use 70 tokens': 'Utiliser 70 jetons',
    'Not enough tokens': 'Pas assez de jetons',
    'Visual body': 'Corps visuel',
    'Progress graphs': 'Graphiques de progression',
    'Gradual-reduction calendar': 'Calendrier de réduction progressive',
    'Use 35 tokens': 'Utiliser 35 jetons',
    'Choose up to': 'Choisissez jusqu’à',
    'habits and set their point values.':
        'habitudes et définissez leurs points.',
  },
  'uz': {
    'Visual You Plus': 'Visual You Plus',
    'Choose your plan': 'Tarifni tanlang',
    'Build your best Visual You': 'Eng yaxshi Visual You’ingizni yarating',
    'Choose the plan that fits your journey. You can change it later.':
        'Yo‘lingizga mos tarifni tanlang. Uni keyin o‘zgartirish mumkin.',
    'Free': 'Bepul',
    'Current plan': 'Joriy tarif',
    'Switch to Free': 'Bepulga o‘tish',
    'Preview Plus': 'Plusni sinash',
    'Core habit tracking': 'Asosiy odat kuzatuvi',
    '3 habits in the custom graph': 'Maxsus grafikda 3 ta odat',
    '2 special habit graphs': '2 ta maxsus odat grafigi',
    '1 gradual-reduction calendar':
        '1 ta bosqichma-bosqich kamaytirish taqvimi',
    'Weekly token unlocks': 'Token bilan haftalik ochish',
    'Everything in Free': 'Bepul tarifdagi barcha imkoniyatlar',
    'High sugar consumption tracking': 'Ko‘p shakar iste’molini kuzatish',
    '6 habits in the custom graph': 'Maxsus grafikda 6 ta odat',
    '4 special habit graphs': '4 ta maxsus odat grafigi',
    '2 gradual-reduction calendars':
        '2 ta bosqichma-bosqich kamaytirish taqvimi',
    'All weekly feature locks removed': 'Haftalik cheklovlarsiz',
    '70 bonus tokens every month': 'Har oy 70 ta bonus token',
    'Future premium integrations': 'Kelajakdagi premium integratsiyalar',
    'This is a local preview. Store billing will be connected before release.':
        'Bu mahalliy sinov ko‘rinishi. Do‘kon to‘lovi ilova chiqarilishidan oldin ulanadi.',
    'Streak': 'Ketma-ketlik',
    'Tokens': 'Tokenlar',
    'Badges': 'Nishonlar',
    'Your streak path': 'Ketma-ketlik yo‘lingiz',
    'Bronze badges': 'Bronza nishonlar',
    'Profile': 'Profil',
    'Body': 'Tana',
    'Unlock for 7 days': '7 kunga ochish',
    'Use 70 tokens': '70 token ishlatish',
    'Not enough tokens': 'Tokenlar yetarli emas',
    'Visual body': 'Vizual tana',
    'Progress graphs': 'Rivojlanish grafiklari',
    'Gradual-reduction calendar': 'Bosqichma-bosqich kamaytirish taqvimi',
    'Use 35 tokens': '35 token ishlatish',
    'Choose up to': 'Ko‘pi bilan',
    'habits and set their point values.':
        'ta odat tanlang va ballarini belgilang.',
  },
};

const Map<String, Map<String, String>> _translations = {
  'en': {
    'Body statistics': 'Body statistics',
    'Calendar': 'Calendar',
    'Previous month': 'Previous month',
    'Next month': 'Next month',
    'Terrible': 'Terrible',
    'OK': 'OK',
    'Excellent': 'Excellent',
    'No habits logged': 'No habits logged',
    'What you did': 'What you did',
    'Habits I did': 'Habits I did',
    "What I didn't do": "What I didn't do",
    'Gradual reduction': 'Gradual reduction',
    'Create plan': 'Create plan',
    'Create reduction plan': 'Create reduction plan',
    'Second reduction plan': 'Second reduction plan',
    'Change reduction plan': 'Change reduction plan',
    'Start date': 'Start date',
    'Choose tracker start date': 'Choose tracker start date',
    'Did you do this habit?': 'Did you do this habit?',
    'I did not': 'I did not',
    'Starts with five allowed days, then reduces gradually with longer repeated cycles.':
        'Starts with five allowed days, then reduces gradually with longer repeated cycles.',
    'Scheduled days are planned maximum-use checkpoints. Skipping or changing them is always okay.':
        'Scheduled days are planned maximum-use checkpoints. Skipping or changing them is always okay.',
    'Change plan': 'Change plan',
    'Choose unwanted habit': 'Choose unwanted habit',
    'No unwanted habits available': 'No unwanted habits available',
    'Quit method': 'Quit method',
    'Hard': 'Hard',
    'Medium': 'Medium',
    'Easy': 'Easy',
    'Coming later': 'Coming later',
    'Start plan': 'Start plan',
    'Stay free': 'Stay free',
    'Scheduled day': 'Scheduled day',
    'Off-plan use': 'Off-plan use',
    'Create a custom calendar that spaces an unwanted habit farther apart over time.':
        'Create a custom calendar that spaces an unwanted habit farther apart over time.',
    'Starts today, then spaces checkpoints by 2, 3, 4, 5 days and progressively farther apart.':
        'Starts today, then spaces checkpoints by 2, 3, 4, 5 days and progressively farther apart.',
    'Repeats each gap as many times as its day number, with allowed windows that become smaller again at long intervals.':
        'Repeats each gap as many times as its day number, with allowed windows that become smaller again at long intervals.',
    'Dark circles are planned maximum-use checkpoints. Skipping them is always okay.':
        'Dark circles are planned maximum-use checkpoints. Skipping them is always okay.',
    'If you may be dependent on alcohol, reducing or stopping suddenly can be dangerous. Seek medical support.':
        'If you may be dependent on alcohol, reducing or stopping suddenly can be dangerous. Seek medical support.',
    'AI coach': 'AI coach',
    'Open profile': 'Open profile',
    'Settings': 'Settings',
    'Home': 'Home',
    'Add habit': 'Add habit',
    'Close': 'Close',
    'Hi!': 'Hi!',
    'Let\'s build a better you': 'Let\'s build a better you',
    'Quick add': 'Quick add',
    'Water': 'Water',
    'Healthy meal': 'Healthy meal',
    'Arm workout': 'Arm workout',
    'Abs workout': 'Abs workout',
    'Smoke-free': 'Smoke-free',
    'Consuming sugar': 'Consuming sugar',
    'Alcohol': 'Alcohol',
    'Add a habit': 'Add a habit',
    'Good habits': 'Good habits ✨',
    'Drinking water': 'Drinking water',
    'Eating healthy': 'Eating healthy',
    'Exercises': 'Exercises',
    'Bad habits': 'Bad habits ❌',
    'Smoking': 'Smoking',
    'Vaping': 'Vaping',
    'Unhealthy eating': 'Unhealthy eating',
    'Adult videos': 'Adult videos',
    'Masturbation': 'Masturbation',
    'Arm': 'Arm',
    'Shoulder / Back': 'Shoulder / Back',
    'Chest': 'Chest',
    'Abs': 'Abs',
    'Legs': 'Legs',
    'I did': 'I did',
    'Back': 'Back',
    'Edit profile': 'Edit profile',
    'Your Name': 'Your Name',
    'Gender': 'Gender',
    'Age': 'Age',
    'Not set': 'Not set',
    'Name': 'Name',
    'Male': 'Male',
    'Female': 'Female',
    'Cancel': 'Cancel',
    'I did this habit': 'I did this habit',
    'I missed this habit': 'I missed this habit',
    'I avoided this habit': 'I avoided this habit',
    'Habit status saved': 'Habit status saved',
    'Change this reduction plan?': 'Change this reduction plan?',
    'Changing it will replace this habit’s current schedule and start date.':
        'Changing it will replace this habit’s current schedule and start date.',
    'Edit habits': 'Edit habits',
    'Edit habit': 'Edit habit',
    'Finish editing': 'Finish editing',
    'Use the star for Quick Add. Remove or restore habits with the button beside it.':
        'Use the star for Quick Add. Remove or restore habits with the button beside it.',
    'Remove from Quick Add': 'Remove from Quick Add',
    'Add to Quick Add': 'Add to Quick Add',
    'Remove habit': 'Remove habit',
    'Restore habit': 'Restore habit',
    'Choose Quick Add favorites with the pen on the add-habits page.':
        'Choose Quick Add favorites with the pen on the add-habits page.',
    'Save': 'Save',
    'Enter an age from 1 to 120': 'Enter an age from 1 to 120',
    'Appearance': 'Appearance',
    'Choose how VisualYou looks. Your choice applies throughout the app.':
        'Choose how VisualYou looks. Your choice applies throughout the app.',
    'Light': 'Light',
    'System': 'System',
    'Dark': 'Dark',
    'Color theme': 'Color theme',
    'This accent color is used across VisualYou.':
        'This accent color is used across VisualYou.',
    'Blue': 'Blue',
    'Pink': 'Pink',
    'Choose the body displayed on Home and Body Statistics.':
        'Choose the body displayed on Home and Body Statistics.',
    'Language': 'Language',
    'Choose the language used throughout VisualYou.':
        'Choose the language used throughout VisualYou.',
    'English': 'English',
    'Spanish': 'Spanish',
    'Russian': 'Russian',
    'French': 'French',
    'Uzbek': 'Uzbek',
    'Show organs': 'Show organs',
    'Show muscles': 'Show muscles',
    'Performance': 'Performance',
    'Bad': 'Bad',
    'Good': 'Good',
    'Custom graph': 'Main graph',
    'Customize graph': 'Customize graph',
    'Could not load custom graph': 'Could not load custom graph',
    'Choose up to 3 habits and set their point values.':
        'Choose up to 3 habits and set their point values.',
    'Habit': 'Habit',
    'Choose habit': 'Choose habit',
    'Not selected': 'Not selected',
    'If completed': 'If completed',
    'If missed': 'If missed',
    'Points ': 'Points ',
    'Save graph': 'Save graph',
    'Choose different habits.': 'Choose different habits.',
    'Enter valid whole numbers.': 'Enter valid whole numbers.',
    'Could not save custom graph': 'Could not save custom graph',
    'Choose up to 3 habits': 'Choose up to 3 habits',
    'Set up graph': 'Set up graph',
    'Choose special habit': 'Choose special habit',
    'Useful information': 'Useful information',
    'Breathing': 'Breathing',
    'Inhale': 'Inhale',
    'Exhale': 'Exhale',
    'Hold': 'Hold',
    'Take a calm breath': 'Take a calm breath',
    'Pause breathing': 'Pause breathing',
    'Start breathing': 'Start breathing',
    'Breathe after a good habit to link each breath with that positive feeling. Before an unwanted habit, breathe to pause, think, and remember how good your better choice felt.':
        'Breathe after a good habit to link each breath with that positive feeling. Before an unwanted habit, breathe to pause, think, and remember how good your better choice felt.',
    'Alcohol can affect many organs and may also strain relationships and friendships.':
        'Alcohol can affect many organs and may also strain relationships and friendships.',
    'Cigarette smoke contains more than 7,000 chemicals, including many that are toxic.':
        'Cigarette smoke contains more than 7,000 chemicals, including many that are toxic.',
    'Frequent explicit content can create unrealistic expectations about bodies and intimacy, and may contribute to guilt or distress.':
        'Frequent explicit content can create unrealistic expectations about bodies and intimacy, and may contribute to guilt or distress.',
    'Drinking enough water supports normal physical and mental performance.':
        'Drinking enough water supports normal physical and mental performance.',
    'Regular physical activity supports the heart, muscles, bones, and mental well-being.':
        'Regular physical activity supports the heart, muscles, bones, and mental well-being.',
    'A balanced and varied diet supports energy and helps protect long-term health.':
        'A balanced and varied diet supports energy and helps protect long-term health.',
    'Could not open offline storage': 'Could not open offline storage',
    'Could not save habit offline': 'Could not save habit offline',
    'Retry': 'Retry',
    'Welcome to': 'Welcome to',
    'Track your habits visually, build healthier routines, reduce unwanted behaviors with clear plans, and get guidance from AI—all in one place.':
        'Track your habits visually, build healthier routines, reduce unwanted behaviors with clear plans, and get guidance from AI—all in one place.',
    'Next': 'Next',
    'Set up later': 'Set up later',
    'Previous': 'Previous',
    'Choose language': 'Choose language',
    'App appearance': 'App appearance',
    'Theme': 'Theme',
    'Choose how the app looks.': 'Choose how the app looks.',
    'Used throughout the app.': 'Used throughout the app.',
    'Language used throughout the app.': 'Language used throughout the app.',
    'Rewards and access': 'Rewards and access',
    'Token markers show the cost of optional changes or extended features. Choose tokens or a rewarded ad when offered.':
        'Token markers show the cost of optional changes or extended features. Choose tokens or a rewarded ad when offered.',
    'Badges grow with profile, body, and calendar progress. Completing milestones can award tokens.':
        'Badges grow with profile, body, and calendar progress. Completing milestones can award tokens.',
    'Ads': 'Ads',
    'Rewarded ads are an optional alternative to tokens. Plus includes fewer on-board ads.':
        'Rewarded ads are an optional alternative to tokens. Plus includes fewer on-board ads.',
    'Free and Plus access': 'Free and Plus access',
    'Free includes limited core features. Plus makes core features unlimited, while premium extensions can still require the displayed token amount or an ad.':
        'Free includes limited core features. Plus makes core features unlimited, while premium extensions can still require the displayed token amount or an ad.',
    'Privacy and policies': 'Privacy and policies',
    'Log out': 'Log out',
    'Sign out of the account on this device. Local habit data stays on the phone.':
        'Sign out of the account on this device. Local habit data stays on the phone.',
    'Log out of this account on this device?':
        'Log out of this account on this device?',
    'Logged out': 'Logged out',
    'No signed-in account': 'No signed-in account',
    'Welcome page preview': 'Welcome page preview',
    'Open the welcome pages without resetting your onboarding progress.':
        'Open the welcome pages without resetting your onboarding progress.',
    'Preview welcome pages': 'Preview welcome pages',
    'Close preview': 'Close preview',
    'Body Progress': 'Body Progress',
    'Body': 'Body',
    'Progress': 'Progress',
    'welcome_body_description':
        'See your consistency reflected through symbolic organ and muscle colors. Explore body views, follow progress from bad to excellent, and watch habits and workouts shape your visual body.',
    'Gradual title line': 'Gradual',
    'Reduction title line': 'Reduction',
    'Choose an unwanted habit and follow a custom hard, medium, or easy calendar that spaces allowed days farther apart over time. Adjust when needed, record honestly, and reduce at a pace you can sustain.':
        'Choose an unwanted habit and follow a custom hard, medium, or easy calendar that spaces allowed days farther apart over time. Adjust when needed, record honestly, and reduce at a pace you can sustain.',
    'Custom title line': 'Custom',
    'Calendar title line': 'Calendar',
    'Graph title line': 'Graph',
    'Build a personalized calendar graph from up to three habits. Give each success or miss its own positive or negative value, then see all three combine into one line that reveals your progress over time.':
        'Build a personalized calendar graph from up to three habits. Give each success or miss its own positive or negative value, then see all three combine into one line that reveals your progress over time.',
    'More title line': 'More',
    'Features title line': 'Features',
    'Stay motivated with calendars, streaks, badges, reminders, and weekly insights. Personalize your experience and get helpful AI guidance as Visual You grows with you.':
        'Stay motivated with calendars, streaks, badges, reminders, and weekly insights. Personalize your experience and get helpful AI guidance as Visual You grows with you.',
    'Create title line': 'Create',
    'Account title line': 'Account',
    'Sign up with email': 'Sign up with email',
    'Continue with Google': 'Continue with Google',
    'Continue with Apple': 'Continue with Apple',
    'Already have an account?': 'Already have an account?',
    'Log in': 'Log in',
    'Create account': 'Create account',
    'Verify your email': 'Verify your email',
    'Create a password': 'Create a password',
    'We will email you a six-digit verification code.':
        'We will email you a six-digit verification code.',
    'Enter the code sent to your email. It expires in 10 minutes.':
        'Enter the code sent to your email. It expires in 10 minutes.',
    'Your email is verified. Create a secure password to finish.':
        'Your email is verified. Create a secure password to finish.',
    'Enter a valid email address': 'Enter a valid email address',
    'Enter the six-digit code': 'Enter the six-digit code',
    'Passwords do not match': 'Passwords do not match',
    'Continue': 'Continue',
    'Email address': 'Email address',
    'Verification code': 'Verification code',
    'Password': 'Password',
    'Confirm password': 'Confirm password',
    'Your account is ready': 'Your account is ready',
    'Enter your email and password.': 'Enter your email and password.',
    'Signed in': 'Signed in',
    'Almost done': 'Almost done',
    'Date of birth': 'Date of birth',
    'Day': 'Day',
    'Month': 'Month',
    'Year': 'Year',
    'Complete your name and date of birth':
        'Complete your name and date of birth',
    'Add profile picture': 'Add profile picture',
    'Change profile picture': 'Change profile picture',
    'Could not open your photos': 'Could not open your photos',
    'Choose new picture': 'Choose new picture',
    'Adjust picture position': 'Adjust picture position',
    'Remove picture': 'Remove picture',
    'Picture position': 'Picture position',
    'Horizontal position': 'Horizontal position',
    'Vertical position': 'Vertical position',
    'Drag the picture to position it inside the circle':
        'Drag the picture to position it inside the circle',
    'Pinch with two fingers to zoom': 'Pinch with two fingers to zoom',
    'Before you begin': 'Before you begin',
    'Please read and acknowledge these important notes about using Visual You.':
        'Please read and acknowledge these important notes about using Visual You.',
    'Track honestly and consistently': 'Track honestly and consistently',
    'agreement_honesty_note':
        'Be honest with yourself and record your habits consistently, even on difficult days. Try not to skip entries, and follow reduction plans with patience and discipline. Accurate tracking makes your progress more meaningful.',
    'Understand symbolic progress': 'Understand symbolic progress',
    'agreement_symbolic_note':
        'Body, muscle, and organ colors are symbolic progress indicators. They change by adding or subtracting habit points from a neutral average and do not diagnose, measure, or represent the real medical condition of any organ or body part. Reduction calendars are optional behavior-change guides only; you may pause, miss, or adjust them to suit your needs.',
    'I agree to the terms and policies': 'I agree to the terms and policies',
    'Please accept the terms and policies to continue':
        'Please accept the terms and policies to continue',
    'Done': 'Done',
  },
  'es': {
    'Body statistics': 'Estadísticas corporales',
    'Calendar': 'Calendario',
    'Previous month': 'Mes anterior',
    'Next month': 'Mes siguiente',
    'Terrible': 'Terrible',
    'OK': 'Aceptable',
    'Excellent': 'Excelente',
    'No habits logged': 'No hay hábitos registrados',
    'What you did': 'Lo que hiciste',
    'Habits I did': 'Hábitos que realicé',
    "What I didn't do": 'Lo que no hice',
    'Gradual reduction': 'Reducción gradual',
    'Create plan': 'Crear plan',
    'Create reduction plan': 'Crear plan de reducción',
    'Second reduction plan': 'Segundo plan de reducción',
    'Change reduction plan': 'Cambiar plan de reducción',
    'Start date': 'Fecha de inicio',
    'Choose tracker start date': 'Elige la fecha de inicio',
    'Did you do this habit?': '¿Realizaste este hábito?',
    'I did not': 'No lo hice',
    'Starts with five allowed days, then reduces gradually with longer repeated cycles.':
        'Empieza con cinco días permitidos y luego reduce gradualmente con ciclos repetidos más largos.',
    'Scheduled days are planned maximum-use checkpoints. Skipping or changing them is always okay.':
        'Los días programados son límites máximos de uso planificados. Omitirlos o cambiarlos siempre está bien.',
    'Change plan': 'Cambiar plan',
    'Choose unwanted habit': 'Elegir hábito no deseado',
    'No unwanted habits available': 'No hay hábitos no deseados disponibles',
    'Quit method': 'Método para dejarlo',
    'Hard': 'Difícil',
    'Medium': 'Medio',
    'Easy': 'Fácil',
    'Coming later': 'Próximamente',
    'Start plan': 'Iniciar plan',
    'Stay free': 'Mantente libre',
    'Scheduled day': 'Día programado',
    'Off-plan use': 'Fuera del plan',
    'Create a custom calendar that spaces an unwanted habit farther apart over time.':
        'Crea un calendario que separe cada vez más un hábito no deseado.',
    'Starts today, then spaces checkpoints by 2, 3, 4, 5 days and progressively farther apart.':
        'Empieza hoy y separa los puntos de control por 2, 3, 4 y 5 días, cada vez más.',
    'Repeats each gap as many times as its day number, with allowed windows that become smaller again at long intervals.':
        'Repite cada intervalo tantas veces como su número de días, con ventanas permitidas que vuelven a reducirse en intervalos largos.',
    'Dark circles are planned maximum-use checkpoints. Skipping them is always okay.':
        'Los círculos oscuros son límites máximos planificados. Omitirlos siempre está bien.',
    'If you may be dependent on alcohol, reducing or stopping suddenly can be dangerous. Seek medical support.':
        'Si puedes tener dependencia del alcohol, reducirlo o dejarlo de repente puede ser peligroso. Busca ayuda médica.',
    'AI coach': 'Entrenador de IA',
    'Open profile': 'Abrir perfil',
    'Settings': 'Ajustes',
    'Home': 'Inicio',
    'Add habit': 'Añadir hábito',
    'Close': 'Cerrar',
    'Hi!': '¡Hola!',
    'Let\'s build a better you': 'Construyamos una mejor versión de ti',
    'Quick add': 'Añadir rápido',
    'Water': 'Agua',
    'Healthy meal': 'Comida saludable',
    'Arm workout': 'Entrenamiento de brazos',
    'Abs workout': 'Entrenamiento abdominal',
    'Smoke-free': 'Sin fumar',
    'Consuming sugar': 'Consumir azúcar',
    'Alcohol': 'Alcohol',
    'Add a habit': 'Añadir un hábito',
    'Good habits': 'Buenos hábitos ✨',
    'Drinking water': 'Beber agua',
    'Eating healthy': 'Comer sano',
    'Exercises': 'Ejercicios',
    'Bad habits': 'Malos hábitos ❌',
    'Smoking': 'Fumar',
    'Vaping': 'Vapear',
    'Unhealthy eating': 'Comida poco saludable',
    'Adult videos': 'Videos para adultos',
    'Masturbation': 'Masturbación',
    'Arm': 'Brazos',
    'Shoulder / Back': 'Hombros / Espalda',
    'Chest': 'Pecho',
    'Abs': 'Abdominales',
    'Legs': 'Piernas',
    'I did': 'Realicé',
    'Back': 'Atrás',
    'Edit profile': 'Editar perfil',
    'Your Name': 'Tu nombre',
    'Gender': 'Género',
    'Age': 'Edad',
    'Not set': 'Sin definir',
    'Name': 'Nombre',
    'Male': 'Masculino',
    'Female': 'Femenino',
    'Cancel': 'Cancelar',
    'I did this habit': 'Realicé este hábito',
    'I missed this habit': 'No realicé este hábito',
    'I avoided this habit': 'Evité este hábito',
    'Habit status saved': 'Estado del hábito guardado',
    'Change this reduction plan?': '¿Cambiar este plan de reducción?',
    'Changing it will replace this habit’s current schedule and start date.':
        'Al cambiarlo se reemplazarán el horario y la fecha de inicio actuales de este hábito.',
    'Edit habits': 'Editar hábitos',
    'Edit habit': 'Editar hábito',
    'Finish editing': 'Terminar edición',
    'Use the star for Quick Add. Remove or restore habits with the button beside it.':
        'Usa la estrella para Añadir rápido. Elimina o restaura hábitos con el botón de al lado.',
    'Remove from Quick Add': 'Quitar de Añadir rápido',
    'Add to Quick Add': 'Añadir a Añadir rápido',
    'Remove habit': 'Eliminar hábito',
    'Restore habit': 'Restaurar hábito',
    'Choose Quick Add favorites with the pen on the add-habits page.':
        'Elige favoritos de Añadir rápido con el lápiz de la página de hábitos.',
    'Save': 'Guardar',
    'Enter an age from 1 to 120': 'Introduce una edad entre 1 y 120',
    'Appearance': 'Apariencia',
    'Choose how VisualYou looks. Your choice applies throughout the app.':
        'Elige cómo se ve VisualYou. Tu elección se aplica a toda la aplicación.',
    'Light': 'Claro',
    'System': 'Sistema',
    'Dark': 'Oscuro',
    'Color theme': 'Tema de color',
    'This accent color is used across VisualYou.':
        'Este color se usa en todo VisualYou.',
    'Blue': 'Azul',
    'Pink': 'Rosa',
    'Choose the body displayed on Home and Body Statistics.':
        'Elige el cuerpo que se muestra en Inicio y Estadísticas corporales.',
    'Language': 'Idioma',
    'Choose the language used throughout VisualYou.':
        'Elige el idioma utilizado en VisualYou.',
    'English': 'Inglés',
    'Spanish': 'Español',
    'Russian': 'Ruso',
    'French': 'Francés',
    'Uzbek': 'Uzbeko',
    'Show organs': 'Mostrar órganos',
    'Show muscles': 'Mostrar músculos',
    'Performance': 'Rendimiento',
    'Bad': 'Malo',
    'Good': 'Bueno',
    'Custom graph': 'Gráfico principal',
    'Customize graph': 'Personalizar gráfico',
    'Could not load custom graph': 'No se pudo cargar el gráfico',
    'Choose up to 3 habits and set their point values.':
        'Elige hasta 3 hábitos y establece sus puntos.',
    'Habit': 'Hábito',
    'Choose habit': 'Elegir hábito',
    'Not selected': 'Sin seleccionar',
    'If completed': 'Si se cumple',
    'If missed': 'Si no se cumple',
    'Points ': 'Puntos ',
    'Save graph': 'Guardar gráfico',
    'Choose different habits.': 'Elige hábitos diferentes.',
    'Enter valid whole numbers.': 'Introduce números enteros válidos.',
    'Could not save custom graph': 'No se pudo guardar el gráfico',
    'Choose up to 3 habits': 'Elige hasta 3 hábitos',
    'Set up graph': 'Configurar gráfico',
    'Choose special habit': 'Elegir hábito especial',
    'Useful information': 'Información útil',
    'Breathing': 'Respiración',
    'Inhale': 'Inhala',
    'Exhale': 'Exhala',
    'Hold': 'Mantén',
    'Take a calm breath': 'Respira con calma',
    'Pause breathing': 'Pausar respiración',
    'Start breathing': 'Iniciar respiración',
    'Breathe after a good habit to link each breath with that positive feeling. Before an unwanted habit, breathe to pause, think, and remember how good your better choice felt.':
        'Respira después de un buen hábito para asociar cada respiración con esa sensación positiva. Antes de un hábito no deseado, respira para detenerte, pensar y recordar lo bien que se sintió elegir mejor.',
    'Alcohol can affect many organs and may also strain relationships and friendships.':
        'El alcohol puede afectar a muchos órganos y también perjudicar las relaciones y amistades.',
    'Cigarette smoke contains more than 7,000 chemicals, including many that are toxic.':
        'El humo del cigarrillo contiene más de 7.000 sustancias químicas, muchas de ellas tóxicas.',
    'Frequent explicit content can create unrealistic expectations about bodies and intimacy, and may contribute to guilt or distress.':
        'El contenido explícito frecuente puede crear expectativas irreales sobre el cuerpo y la intimidad, y contribuir a la culpa o al malestar.',
    'Drinking enough water supports normal physical and mental performance.':
        'Beber suficiente agua favorece el rendimiento físico y mental normal.',
    'Regular physical activity supports the heart, muscles, bones, and mental well-being.':
        'La actividad física regular beneficia al corazón, los músculos, los huesos y el bienestar mental.',
    'A balanced and varied diet supports energy and helps protect long-term health.':
        'Una alimentación equilibrada y variada aporta energía y ayuda a proteger la salud a largo plazo.',
    'Could not open offline storage':
        'No se pudo abrir el almacenamiento sin conexión',
    'Could not save habit offline': 'No se pudo guardar el hábito sin conexión',
    'Retry': 'Reintentar',
    'Welcome to': 'Bienvenido a',
    'Track your habits visually, build healthier routines, reduce unwanted behaviors with clear plans, and get guidance from AI—all in one place.':
        'Sigue tus hábitos visualmente, crea rutinas más saludables, reduce conductas no deseadas con planes claros y recibe orientación de la IA, todo en un solo lugar.',
    'Next': 'Siguiente',
    'Set up later': 'Configurar más tarde',
    'Previous': 'Anterior',
    'Choose language': 'Elegir idioma',
    'App appearance': 'Apariencia de la aplicación',
    'Theme': 'Tema',
    'Choose how the app looks.': 'Elige cómo se ve la aplicación.',
    'Used throughout the app.': 'Se usa en toda la aplicación.',
    'Language used throughout the app.': 'Idioma usado en toda la aplicación.',
    'Rewards and access': 'Recompensas y acceso',
    'Token markers show the cost of optional changes or extended features. Choose tokens or a rewarded ad when offered.':
        'Los indicadores de fichas muestran el coste de cambios opcionales o funciones ampliadas. Elige fichas o un anuncio con recompensa cuando esté disponible.',
    'Badges grow with profile, body, and calendar progress. Completing milestones can award tokens.':
        'Las insignias avanzan con el perfil, el cuerpo y el calendario. Completar objetivos puede otorgar fichas.',
    'Ads': 'Anuncios',
    'Rewarded ads are an optional alternative to tokens. Plus includes fewer on-board ads.':
        'Los anuncios con recompensa son una alternativa opcional a las fichas. Plus incluye menos anuncios integrados.',
    'Free and Plus access': 'Acceso Free y Plus',
    'Free includes limited core features. Plus makes core features unlimited, while premium extensions can still require the displayed token amount or an ad.':
        'Free incluye funciones principales limitadas. Plus hace ilimitadas las funciones principales, aunque las extensiones premium aún pueden requerir las fichas indicadas o un anuncio.',
    'Privacy and policies': 'Privacidad y políticas',
    'Log out': 'Cerrar sesión',
    'Sign out of the account on this device. Local habit data stays on the phone.':
        'Cierra la sesión de la cuenta en este dispositivo. Los datos locales de hábitos permanecen en el teléfono.',
    'Log out of this account on this device?':
        '¿Cerrar la sesión de esta cuenta en este dispositivo?',
    'Logged out': 'Sesión cerrada',
    'No signed-in account': 'No hay una cuenta con sesión iniciada',
    'Welcome page preview': 'Vista previa de bienvenida',
    'Open the welcome pages without resetting your onboarding progress.':
        'Abre las páginas de bienvenida sin restablecer tu progreso de introducción.',
    'Preview welcome pages': 'Ver páginas de bienvenida',
    'Close preview': 'Cerrar vista previa',
    'Body Progress': 'Progreso corporal',
    'Body': 'Cuerpo',
    'Progress': 'Progreso',
    'welcome_body_description':
        'Observa tu constancia mediante colores simbólicos en órganos y músculos. Explora las vistas del cuerpo, sigue tu progreso de malo a excelente y descubre cómo tus hábitos y entrenamientos dan forma a tu cuerpo visual.',
    'Gradual title line': 'Reducción',
    'Reduction title line': 'gradual',
    'Choose an unwanted habit and follow a custom hard, medium, or easy calendar that spaces allowed days farther apart over time. Adjust when needed, record honestly, and reduce at a pace you can sustain.':
        'Elige un hábito no deseado y sigue un calendario personalizado difícil, medio o fácil que separe cada vez más los días permitidos. Ajústalo cuando sea necesario, registra con sinceridad y reduce a un ritmo sostenible.',
    'Custom title line': 'Gráfico',
    'Calendar title line': 'personalizado',
    'Graph title line': 'personalizado',
    'Build a personalized calendar graph from up to three habits. Give each success or miss its own positive or negative value, then see all three combine into one line that reveals your progress over time.':
        'Crea un gráfico de calendario personalizado con hasta tres hábitos. Asigna a cada logro o falta un valor positivo o negativo y observa cómo los tres se combinan en una sola línea que muestra tu progreso con el tiempo.',
    'More title line': 'Más',
    'Features title line': 'funciones',
    'Stay motivated with calendars, streaks, badges, reminders, and weekly insights. Personalize your experience and get helpful AI guidance as Visual You grows with you.':
        'Mantén la motivación con calendarios, rachas, insignias, recordatorios e informes semanales. Personaliza tu experiencia y recibe orientación útil de la IA mientras Visual You crece contigo.',
    'Create title line': 'Crear',
    'Account title line': 'cuenta',
    'Sign up with email': 'Registrarse con correo',
    'Continue with Google': 'Continuar con Google',
    'Continue with Apple': 'Continuar con Apple',
    'Already have an account?': '¿Ya tienes una cuenta?',
    'Log in': 'Iniciar sesión',
    'Create account': 'Crear cuenta',
    'Verify your email': 'Verifica tu correo',
    'Create a password': 'Crea una contraseña',
    'We will email you a six-digit verification code.':
        'Te enviaremos por correo un código de verificación de seis dígitos.',
    'Enter the code sent to your email. It expires in 10 minutes.':
        'Introduce el código enviado a tu correo. Caduca en 10 minutos.',
    'Your email is verified. Create a secure password to finish.':
        'Tu correo está verificado. Crea una contraseña segura para terminar.',
    'Enter a valid email address': 'Introduce un correo electrónico válido',
    'Enter the six-digit code': 'Introduce el código de seis dígitos',
    'Passwords do not match': 'Las contraseñas no coinciden',
    'Continue': 'Continuar',
    'Email address': 'Correo electrónico',
    'Verification code': 'Código de verificación',
    'Password': 'Contraseña',
    'Confirm password': 'Confirmar contraseña',
    'Your account is ready': 'Tu cuenta está lista',
    'Enter your email and password.': 'Introduce tu correo y contraseña.',
    'Signed in': 'Sesión iniciada',
    'Almost done': 'Casi terminamos',
    'Date of birth': 'Fecha de nacimiento',
    'Day': 'Día',
    'Month': 'Mes',
    'Year': 'Año',
    'Complete your name and date of birth':
        'Completa tu nombre y fecha de nacimiento',
    'Add profile picture': 'Añadir foto de perfil',
    'Change profile picture': 'Cambiar foto de perfil',
    'Could not open your photos': 'No se pudieron abrir tus fotos',
    'Choose new picture': 'Elegir otra foto',
    'Adjust picture position': 'Ajustar la posición de la foto',
    'Remove picture': 'Eliminar foto',
    'Picture position': 'Posición de la foto',
    'Horizontal position': 'Posición horizontal',
    'Vertical position': 'Posición vertical',
    'Drag the picture to position it inside the circle':
        'Arrastra la foto para colocarla dentro del círculo',
    'Pinch with two fingers to zoom': 'Pellizca con dos dedos para ampliar',
    'Before you begin': 'Antes de comenzar',
    'Please read and acknowledge these important notes about using Visual You.':
        'Lee y reconoce estas notas importantes sobre el uso de Visual You.',
    'Track honestly and consistently': 'Registra con honestidad y constancia',
    'agreement_honesty_note':
        'Sé honesto contigo mismo y registra tus hábitos con constancia, incluso en los días difíciles. Intenta no omitir registros y sigue los planes de reducción con paciencia y disciplina. Un seguimiento preciso hace que tu progreso sea más significativo.',
    'Understand symbolic progress': 'Comprende el progreso simbólico',
    'agreement_symbolic_note':
        'Los colores del cuerpo, los músculos y los órganos son indicadores simbólicos de progreso. Cambian al sumar o restar puntos de hábitos desde una etapa media neutral y no diagnostican, miden ni representan la condición médica real de ningún órgano o parte del cuerpo. Los calendarios de reducción son solo guías opcionales para cambiar hábitos; puedes pausarlos, omitir días o ajustarlos según tus necesidades.',
    'I agree to the terms and policies': 'Acepto los términos y las políticas',
    'Please accept the terms and policies to continue':
        'Acepta los términos y las políticas para continuar',
    'Done': 'Listo',
  },
  'ru': {
    'Body statistics': 'Статистика тела',
    'Calendar': 'Календарь',
    'Previous month': 'Предыдущий месяц',
    'Next month': 'Следующий месяц',
    'Terrible': 'Ужасно',
    'OK': 'Нормально',
    'Excellent': 'Отлично',
    'No habits logged': 'Нет записей о привычках',
    'What you did': 'Что вы сделали',
    'Habits I did': 'Привычки, которые я выполнил(а)',
    "What I didn't do": 'Что я не сделал(а)',
    'Gradual reduction': 'Постепенное сокращение',
    'Create plan': 'Создать план',
    'Create reduction plan': 'Создать план сокращения',
    'Second reduction plan': 'Второй план сокращения',
    'Change reduction plan': 'Изменить план сокращения',
    'Start date': 'Дата начала',
    'Choose tracker start date': 'Выберите дату начала',
    'Did you do this habit?': 'Вы выполнили эту привычку?',
    'I did not': 'Нет',
    'Starts with five allowed days, then reduces gradually with longer repeated cycles.':
        'Начинается с пяти разрешённых дней, затем постепенно сокращается с более длинными повторяющимися циклами.',
    'Scheduled days are planned maximum-use checkpoints. Skipping or changing them is always okay.':
        'Запланированные дни — это пределы максимального употребления. Их всегда можно пропустить или изменить.',
    'Change plan': 'Изменить план',
    'Choose unwanted habit': 'Выберите нежелательную привычку',
    'No unwanted habits available': 'Нет доступных нежелательных привычек',
    'Quit method': 'Способ отказа',
    'Hard': 'Сложный',
    'Medium': 'Средний',
    'Easy': 'Лёгкий',
    'Coming later': 'Будет позже',
    'Start plan': 'Начать план',
    'Stay free': 'Без привычки',
    'Scheduled day': 'Плановый день',
    'Off-plan use': 'Вне плана',
    'Create a custom calendar that spaces an unwanted habit farther apart over time.':
        'Создайте календарь, который постепенно увеличивает интервалы между нежелательной привычкой.',
    'Starts today, then spaces checkpoints by 2, 3, 4, 5 days and progressively farther apart.':
        'Начинается сегодня, затем интервалы составляют 2, 3, 4, 5 дней и постепенно увеличиваются.',
    'Repeats each gap as many times as its day number, with allowed windows that become smaller again at long intervals.':
        'Каждый интервал повторяется столько раз, сколько в нём дней, а при больших интервалах разрешённые окна снова сокращаются.',
    'Dark circles are planned maximum-use checkpoints. Skipping them is always okay.':
        'Тёмные круги — максимально допустимые плановые дни. Их всегда можно пропустить.',
    'If you may be dependent on alcohol, reducing or stopping suddenly can be dangerous. Seek medical support.':
        'При возможной алкогольной зависимости резкое сокращение или прекращение может быть опасным. Обратитесь за медицинской помощью.',
    'AI coach': 'ИИ-тренер',
    'Open profile': 'Открыть профиль',
    'Settings': 'Настройки',
    'Home': 'Главная',
    'Add habit': 'Добавить привычку',
    'Close': 'Закрыть',
    'Hi!': 'Привет!',
    'Let\'s build a better you': 'Давайте создадим лучшую версию вас',
    'Quick add': 'Быстрое добавление',
    'Water': 'Вода',
    'Healthy meal': 'Полезная еда',
    'Arm workout': 'Тренировка рук',
    'Abs workout': 'Тренировка пресса',
    'Smoke-free': 'Без курения',
    'Consuming sugar': 'Употребление сахара',
    'Alcohol': 'Алкоголь',
    'Add a habit': 'Добавить привычку',
    'Good habits': 'Полезные привычки ✨',
    'Drinking water': 'Пить воду',
    'Eating healthy': 'Здоровое питание',
    'Exercises': 'Упражнения',
    'Bad habits': 'Вредные привычки ❌',
    'Smoking': 'Курение',
    'Vaping': 'Вейпинг',
    'Unhealthy eating': 'Нездоровое питание',
    'Adult videos': 'Видео для взрослых',
    'Masturbation': 'Мастурбация',
    'Arm': 'Руки',
    'Shoulder / Back': 'Плечи / Спина',
    'Chest': 'Грудь',
    'Abs': 'Пресс',
    'Legs': 'Ноги',
    'I did': 'Выполнено',
    'Back': 'Назад',
    'Edit profile': 'Изменить профиль',
    'Your Name': 'Ваше имя',
    'Gender': 'Пол',
    'Age': 'Возраст',
    'Not set': 'Не указано',
    'Name': 'Имя',
    'Male': 'Мужской',
    'Female': 'Женский',
    'Cancel': 'Отмена',
    'I did this habit': 'Я выполнил эту привычку',
    'I missed this habit': 'Я пропустил эту привычку',
    'I avoided this habit': 'Я избежал этой привычки',
    'Habit status saved': 'Статус привычки сохранён',
    'Change this reduction plan?': 'Изменить этот план сокращения?',
    'Changing it will replace this habit’s current schedule and start date.':
        'Изменение заменит текущее расписание и дату начала этой привычки.',
    'Edit habits': 'Изменить привычки',
    'Edit habit': 'Изменить привычку',
    'Finish editing': 'Завершить редактирование',
    'Use the star for Quick Add. Remove or restore habits with the button beside it.':
        'Звезда добавляет привычку в быстрый доступ. Кнопка рядом удаляет или восстанавливает её.',
    'Remove from Quick Add': 'Убрать из быстрого доступа',
    'Add to Quick Add': 'Добавить в быстрый доступ',
    'Remove habit': 'Удалить привычку',
    'Restore habit': 'Восстановить привычку',
    'Choose Quick Add favorites with the pen on the add-habits page.':
        'Выберите быстрые привычки с помощью карандаша на странице добавления.',
    'Save': 'Сохранить',
    'Enter an age from 1 to 120': 'Введите возраст от 1 до 120',
    'Appearance': 'Оформление',
    'Choose how VisualYou looks. Your choice applies throughout the app.':
        'Выберите оформление VisualYou. Оно применяется ко всему приложению.',
    'Light': 'Светлая',
    'System': 'Системная',
    'Dark': 'Тёмная',
    'Color theme': 'Цветовая тема',
    'This accent color is used across VisualYou.':
        'Этот цвет используется во всём VisualYou.',
    'Blue': 'Синий',
    'Pink': 'Розовый',
    'Choose the body displayed on Home and Body Statistics.':
        'Выберите тело для главной страницы и статистики тела.',
    'Language': 'Язык',
    'Choose the language used throughout VisualYou.':
        'Выберите язык интерфейса VisualYou.',
    'English': 'Английский',
    'Spanish': 'Испанский',
    'Russian': 'Русский',
    'French': 'Французский',
    'Uzbek': 'Узбекский',
    'Show organs': 'Показать органы',
    'Show muscles': 'Показать мышцы',
    'Performance': 'Результат',
    'Bad': 'Плохо',
    'Good': 'Хорошо',
    'Custom graph': 'Основной график',
    'Customize graph': 'Настроить график',
    'Could not load custom graph': 'Не удалось загрузить график',
    'Choose up to 3 habits and set their point values.':
        'Выберите до 3 привычек и задайте баллы.',
    'Habit': 'Привычка',
    'Choose habit': 'Выбрать привычку',
    'Not selected': 'Не выбрано',
    'If completed': 'Если выполнено',
    'If missed': 'Если пропущено',
    'Points ': 'Баллы ',
    'Save graph': 'Сохранить график',
    'Choose different habits.': 'Выберите разные привычки.',
    'Enter valid whole numbers.': 'Введите целые числа.',
    'Could not save custom graph': 'Не удалось сохранить график',
    'Choose up to 3 habits': 'Выберите до 3 привычек',
    'Set up graph': 'Настроить график',
    'Choose special habit': 'Выбрать особую привычку',
    'Useful information': 'Полезная информация',
    'Breathing': 'Дыхание',
    'Inhale': 'Вдох',
    'Exhale': 'Выдох',
    'Hold': 'Задержите',
    'Take a calm breath': 'Сделайте спокойный вдох',
    'Pause breathing': 'Приостановить дыхание',
    'Start breathing': 'Начать дыхание',
    'Breathe after a good habit to link each breath with that positive feeling. Before an unwanted habit, breathe to pause, think, and remember how good your better choice felt.':
        'Подышите после полезной привычки, чтобы связать дыхание с приятным ощущением. Перед нежелательной привычкой сделайте паузу, подышите и вспомните, как хорошо было выбрать лучшее решение.',
    'Alcohol can affect many organs and may also strain relationships and friendships.':
        'Алкоголь может влиять на многие органы, а также ухудшать отношения и дружбу.',
    'Cigarette smoke contains more than 7,000 chemicals, including many that are toxic.':
        'Сигаретный дым содержит более 7 000 химических веществ, многие из которых токсичны.',
    'Frequent explicit content can create unrealistic expectations about bodies and intimacy, and may contribute to guilt or distress.':
        'Частый просмотр откровенного контента может создавать нереалистичные ожидания о теле и близости, а также усиливать чувство вины или дискомфорт.',
    'Drinking enough water supports normal physical and mental performance.':
        'Достаточное употребление воды поддерживает нормальную физическую и умственную работоспособность.',
    'Regular physical activity supports the heart, muscles, bones, and mental well-being.':
        'Регулярная физическая активность поддерживает сердце, мышцы, кости и психологическое благополучие.',
    'A balanced and varied diet supports energy and helps protect long-term health.':
        'Сбалансированное и разнообразное питание поддерживает энергию и здоровье в долгосрочной перспективе.',
    'Could not open offline storage': 'Не удалось открыть автономное хранилище',
    'Could not save habit offline': 'Не удалось сохранить привычку офлайн',
    'Retry': 'Повторить',
    'Welcome to': 'Добро пожаловать в',
    'Track your habits visually, build healthier routines, reduce unwanted behaviors with clear plans, and get guidance from AI—all in one place.':
        'Отслеживайте привычки визуально, формируйте полезные привычки, сокращайте нежелательное поведение по понятным планам и получайте помощь ИИ — всё в одном месте.',
    'Next': 'Далее',
    'Set up later': 'Настроить позже',
    'Previous': 'Назад',
    'Choose language': 'Выбрать язык',
    'App appearance': 'Внешний вид приложения',
    'Theme': 'Тема',
    'Choose how the app looks.': 'Выберите внешний вид приложения.',
    'Used throughout the app.': 'Используется во всём приложении.',
    'Language used throughout the app.': 'Язык всего приложения.',
    'Rewards and access': 'Награды и доступ',
    'Token markers show the cost of optional changes or extended features. Choose tokens or a rewarded ad when offered.':
        'Значки жетонов показывают стоимость дополнительных изменений и функций. Используйте жетоны или рекламу с вознаграждением, когда она доступна.',
    'Badges grow with profile, body, and calendar progress. Completing milestones can award tokens.':
        'Значки развиваются вместе с прогрессом профиля, тела и календаря. За достижение целей можно получить жетоны.',
    'Ads': 'Реклама',
    'Rewarded ads are an optional alternative to tokens. Plus includes fewer on-board ads.':
        'Реклама с вознаграждением — необязательная альтернатива жетонам. В Plus меньше встроенной рекламы.',
    'Free and Plus access': 'Доступ Free и Plus',
    'Free includes limited core features. Plus makes core features unlimited, while premium extensions can still require the displayed token amount or an ad.':
        'Free включает ограниченные основные функции. В Plus основные функции не ограничены, но премиум-расширения всё ещё могут требовать указанное число жетонов или рекламу.',
    'Privacy and policies': 'Конфиденциальность и правила',
    'Log out': 'Выйти',
    'Sign out of the account on this device. Local habit data stays on the phone.':
        'Выйдите из аккаунта на этом устройстве. Локальные данные привычек останутся на телефоне.',
    'Log out of this account on this device?':
        'Выйти из этого аккаунта на данном устройстве?',
    'Logged out': 'Вы вышли из аккаунта',
    'No signed-in account': 'Нет аккаунта с активным входом',
    'Welcome page preview': 'Просмотр страниц приветствия',
    'Open the welcome pages without resetting your onboarding progress.':
        'Откройте страницы приветствия, не сбрасывая прогресс знакомства с приложением.',
    'Preview welcome pages': 'Посмотреть страницы приветствия',
    'Close preview': 'Закрыть просмотр',
    'Body Progress': 'Прогресс тела',
    'Body': 'Тело',
    'Progress': 'Прогресс',
    'welcome_body_description':
        'Наблюдайте за постоянством с помощью символических цветов органов и мышц. Изучайте виды тела, отслеживайте прогресс от плохого до отличного и смотрите, как привычки и тренировки меняют визуальное тело.',
    'Gradual title line': 'Постепенное',
    'Reduction title line': 'сокращение',
    'Choose an unwanted habit and follow a custom hard, medium, or easy calendar that spaces allowed days farther apart over time. Adjust when needed, record honestly, and reduce at a pace you can sustain.':
        'Выберите нежелательную привычку и следуйте персональному сложному, среднему или лёгкому календарю, который постепенно увеличивает расстояние между разрешёнными днями. При необходимости меняйте план, отмечайте честно и сокращайте в устойчивом темпе.',
    'Custom title line': 'Свой',
    'Calendar title line': 'календарь',
    'Graph title line': 'график',
    'Build a personalized calendar graph from up to three habits. Give each success or miss its own positive or negative value, then see all three combine into one line that reveals your progress over time.':
        'Создайте персональный календарный график из трёх привычек. Назначьте каждому успеху или пропуску положительное или отрицательное значение и смотрите, как три привычки объединяются в одну линию прогресса.',
    'More title line': 'Больше',
    'Features title line': 'возможностей',
    'Stay motivated with calendars, streaks, badges, reminders, and weekly insights. Personalize your experience and get helpful AI guidance as Visual You grows with you.':
        'Поддерживайте мотивацию с помощью календарей, серий, значков, напоминаний и еженедельной статистики. Настраивайте приложение и получайте полезные советы ИИ по мере развития Visual You.',
    'Create title line': 'Создайте',
    'Account title line': 'аккаунт',
    'Sign up with email': 'Регистрация по почте',
    'Continue with Google': 'Продолжить с Google',
    'Continue with Apple': 'Продолжить с Apple',
    'Already have an account?': 'Уже есть аккаунт?',
    'Log in': 'Войти',
    'Create account': 'Создать аккаунт',
    'Verify your email': 'Подтвердите почту',
    'Create a password': 'Создайте пароль',
    'We will email you a six-digit verification code.':
        'Мы отправим на вашу почту шестизначный код подтверждения.',
    'Enter the code sent to your email. It expires in 10 minutes.':
        'Введите код из письма. Он действует 10 минут.',
    'Your email is verified. Create a secure password to finish.':
        'Почта подтверждена. Создайте надёжный пароль, чтобы завершить.',
    'Enter a valid email address': 'Введите действительный адрес почты',
    'Enter the six-digit code': 'Введите шестизначный код',
    'Passwords do not match': 'Пароли не совпадают',
    'Continue': 'Продолжить',
    'Email address': 'Электронная почта',
    'Verification code': 'Код подтверждения',
    'Password': 'Пароль',
    'Confirm password': 'Подтвердите пароль',
    'Your account is ready': 'Ваш аккаунт готов',
    'Enter your email and password.': 'Введите электронную почту и пароль.',
    'Signed in': 'Вход выполнен',
    'Almost done': 'Почти готово',
    'Date of birth': 'Дата рождения',
    'Day': 'День',
    'Month': 'Месяц',
    'Year': 'Год',
    'Complete your name and date of birth': 'Укажите имя и дату рождения',
    'Add profile picture': 'Добавить фото профиля',
    'Change profile picture': 'Изменить фото профиля',
    'Could not open your photos': 'Не удалось открыть ваши фотографии',
    'Choose new picture': 'Выбрать другое фото',
    'Adjust picture position': 'Настроить положение фото',
    'Remove picture': 'Удалить фото',
    'Picture position': 'Положение фото',
    'Horizontal position': 'По горизонтали',
    'Vertical position': 'По вертикали',
    'Drag the picture to position it inside the circle':
        'Перетащите фото, чтобы расположить его внутри круга',
    'Pinch with two fingers to zoom':
        'Сведите или разведите два пальца для масштабирования',
    'Before you begin': 'Перед началом',
    'Please read and acknowledge these important notes about using Visual You.':
        'Прочитайте и подтвердите эти важные примечания об использовании Visual You.',
    'Track honestly and consistently': 'Отмечайте честно и регулярно',
    'agreement_honesty_note':
        'Будьте честны с собой и регулярно отмечайте привычки, даже в трудные дни. Старайтесь не пропускать записи и следуйте планам сокращения терпеливо и дисциплинированно. Точные записи делают ваш прогресс более осмысленным.',
    'Understand symbolic progress': 'Понимайте символический прогресс',
    'agreement_symbolic_note':
        'Цвета тела, мышц и органов являются символическими показателями прогресса. Они меняются при добавлении или вычитании баллов привычек из нейтрального среднего уровня и не диагностируют, не измеряют и не отражают реальное медицинское состояние органов или частей тела. Календари сокращения — лишь необязательные рекомендации по изменению поведения; их можно приостанавливать, пропускать или изменять под свои потребности.',
    'I agree to the terms and policies': 'Я принимаю условия и правила',
    'Please accept the terms and policies to continue':
        'Примите условия и правила, чтобы продолжить',
    'Done': 'Готово',
  },
  'fr': {
    'Body statistics': 'Statistiques corporelles',
    'Calendar': 'Calendrier',
    'Previous month': 'Mois précédent',
    'Next month': 'Mois suivant',
    'Terrible': 'Très mauvais',
    'OK': 'Correct',
    'Excellent': 'Excellent',
    'No habits logged': 'Aucune habitude enregistrée',
    'What you did': 'Ce que vous avez fait',
    'Habits I did': "Habitudes que j’ai faites",
    "What I didn't do": "Ce que je n’ai pas fait",
    'Gradual reduction': 'Réduction progressive',
    'Create plan': 'Créer un plan',
    'Create reduction plan': 'Créer un plan de réduction',
    'Second reduction plan': 'Deuxième plan de réduction',
    'Change reduction plan': 'Modifier le plan de réduction',
    'Start date': 'Date de début',
    'Choose tracker start date': 'Choisir la date de début',
    'Did you do this habit?': 'Avez-vous pratiqué cette habitude ?',
    'I did not': 'Non',
    'Starts with five allowed days, then reduces gradually with longer repeated cycles.':
        'Commence par cinq jours autorisés, puis diminue progressivement avec des cycles répétés plus longs.',
    'Scheduled days are planned maximum-use checkpoints. Skipping or changing them is always okay.':
        'Les jours programmés sont des limites planifiées d’usage maximal. Vous pouvez toujours les ignorer ou les modifier.',
    'Change plan': 'Modifier le plan',
    'Choose unwanted habit': 'Choisir une habitude indésirable',
    'No unwanted habits available': 'Aucune habitude indésirable disponible',
    'Quit method': 'Méthode d’arrêt',
    'Hard': 'Difficile',
    'Medium': 'Moyen',
    'Easy': 'Facile',
    'Coming later': 'Bientôt disponible',
    'Start plan': 'Démarrer le plan',
    'Stay free': 'Rester libre',
    'Scheduled day': 'Jour planifié',
    'Off-plan use': 'Hors programme',
    'Create a custom calendar that spaces an unwanted habit farther apart over time.':
        'Créez un calendrier qui espace progressivement une habitude indésirable.',
    'Starts today, then spaces checkpoints by 2, 3, 4, 5 days and progressively farther apart.':
        'Commence aujourd’hui, puis espace les étapes de 2, 3, 4 et 5 jours, progressivement.',
    'Repeats each gap as many times as its day number, with allowed windows that become smaller again at long intervals.':
        'Répète chaque intervalle autant de fois que son nombre de jours, avec des fenêtres autorisées qui diminuent à nouveau sur les longs intervalles.',
    'Dark circles are planned maximum-use checkpoints. Skipping them is always okay.':
        'Les cercles foncés sont des limites maximales planifiées. Vous pouvez toujours les ignorer.',
    'If you may be dependent on alcohol, reducing or stopping suddenly can be dangerous. Seek medical support.':
        'En cas de dépendance possible à l’alcool, réduire ou arrêter brutalement peut être dangereux. Demandez une aide médicale.',
    'AI coach': 'Coach IA',
    'Open profile': 'Ouvrir le profil',
    'Settings': 'Réglages',
    'Home': 'Accueil',
    'Add habit': 'Ajouter une habitude',
    'Close': 'Fermer',
    'Hi!': 'Bonjour !',
    'Let\'s build a better you': 'Construisons une meilleure version de vous',
    'Quick add': 'Ajout rapide',
    'Water': 'Eau',
    'Healthy meal': 'Repas sain',
    'Arm workout': 'Entraînement des bras',
    'Abs workout': 'Entraînement abdominal',
    'Smoke-free': 'Sans tabac',
    'Consuming sugar': 'Consommation de sucre',
    'Alcohol': 'Alcool',
    'Add a habit': 'Ajouter une habitude',
    'Good habits': 'Bonnes habitudes ✨',
    'Drinking water': 'Boire de l’eau',
    'Eating healthy': 'Manger sainement',
    'Exercises': 'Exercices',
    'Bad habits': 'Mauvaises habitudes ❌',
    'Smoking': 'Tabagisme',
    'Vaping': 'Vapotage',
    'Unhealthy eating': 'Alimentation malsaine',
    'Adult videos': 'Vidéos pour adultes',
    'Masturbation': 'Masturbation',
    'Arm': 'Bras',
    'Shoulder / Back': 'Épaules / Dos',
    'Chest': 'Poitrine',
    'Abs': 'Abdominaux',
    'Legs': 'Jambes',
    'I did': 'J’ai fait',
    'Back': 'Retour',
    'Edit profile': 'Modifier le profil',
    'Your Name': 'Votre nom',
    'Gender': 'Genre',
    'Age': 'Âge',
    'Not set': 'Non défini',
    'Name': 'Nom',
    'Male': 'Homme',
    'Female': 'Femme',
    'Cancel': 'Annuler',
    'I did this habit': 'J’ai pratiqué cette habitude',
    'I missed this habit': 'J’ai manqué cette habitude',
    'I avoided this habit': 'J’ai évité cette habitude',
    'Habit status saved': 'Statut de l’habitude enregistré',
    'Change this reduction plan?': 'Modifier ce plan de réduction ?',
    'Changing it will replace this habit’s current schedule and start date.':
        'Cette modification remplacera le programme et la date de début actuels de cette habitude.',
    'Edit habits': 'Modifier les habitudes',
    'Edit habit': "Modifier l’habitude",
    'Finish editing': 'Terminer la modification',
    'Use the star for Quick Add. Remove or restore habits with the button beside it.':
        'Utilisez l’étoile pour l’ajout rapide. Le bouton voisin supprime ou restaure une habitude.',
    'Remove from Quick Add': 'Retirer de l’ajout rapide',
    'Add to Quick Add': 'Ajouter à l’ajout rapide',
    'Remove habit': 'Supprimer l’habitude',
    'Restore habit': 'Restaurer l’habitude',
    'Choose Quick Add favorites with the pen on the add-habits page.':
        'Choisissez les favoris d’ajout rapide avec le crayon de la page des habitudes.',
    'Save': 'Enregistrer',
    'Enter an age from 1 to 120': 'Saisissez un âge entre 1 et 120',
    'Appearance': 'Apparence',
    'Choose how VisualYou looks. Your choice applies throughout the app.':
        'Choisissez l’apparence de VisualYou. Votre choix s’applique partout.',
    'Light': 'Clair',
    'System': 'Système',
    'Dark': 'Sombre',
    'Color theme': 'Thème de couleur',
    'This accent color is used across VisualYou.':
        'Cette couleur est utilisée dans tout VisualYou.',
    'Blue': 'Bleu',
    'Pink': 'Rose',
    'Choose the body displayed on Home and Body Statistics.':
        'Choisissez le corps affiché sur Accueil et Statistiques corporelles.',
    'Language': 'Langue',
    'Choose the language used throughout VisualYou.':
        'Choisissez la langue utilisée dans VisualYou.',
    'English': 'Anglais',
    'Spanish': 'Espagnol',
    'Russian': 'Russe',
    'French': 'Français',
    'Uzbek': 'Ouzbek',
    'Show organs': 'Afficher les organes',
    'Show muscles': 'Afficher les muscles',
    'Performance': 'Performance',
    'Bad': 'Mauvais',
    'Good': 'Bon',
    'Custom graph': 'Graphique principal',
    'Customize graph': 'Personnaliser le graphique',
    'Could not load custom graph': 'Impossible de charger le graphique',
    'Choose up to 3 habits and set their point values.':
        'Choisissez jusqu’à 3 habitudes et définissez leurs points.',
    'Habit': 'Habitude',
    'Choose habit': 'Choisir une habitude',
    'Not selected': 'Non sélectionné',
    'If completed': 'Si réalisée',
    'If missed': 'Si manquée',
    'Points ': 'Points ',
    'Save graph': 'Enregistrer le graphique',
    'Choose different habits.': 'Choisissez des habitudes différentes.',
    'Enter valid whole numbers.': 'Saisissez des nombres entiers valides.',
    'Could not save custom graph': 'Impossible d’enregistrer le graphique',
    'Choose up to 3 habits': 'Choisissez jusqu’à 3 habitudes',
    'Set up graph': 'Configurer le graphique',
    'Choose special habit': 'Choisir une habitude spéciale',
    'Useful information': 'Informations utiles',
    'Breathing': 'Respiration',
    'Inhale': 'Inspirez',
    'Exhale': 'Expirez',
    'Hold': 'Retenez',
    'Take a calm breath': 'Respirez calmement',
    'Pause breathing': 'Mettre en pause',
    'Start breathing': 'Commencer',
    'Breathe after a good habit to link each breath with that positive feeling. Before an unwanted habit, breathe to pause, think, and remember how good your better choice felt.':
        'Respirez après une bonne habitude pour associer chaque souffle à ce sentiment positif. Avant une habitude indésirable, respirez pour faire une pause, réfléchir et vous rappeler le bien-être ressenti après un meilleur choix.',
    'Alcohol can affect many organs and may also strain relationships and friendships.':
        'L’alcool peut affecter de nombreux organes et fragiliser les relations et les amitiés.',
    'Cigarette smoke contains more than 7,000 chemicals, including many that are toxic.':
        'La fumée de cigarette contient plus de 7 000 substances chimiques, dont beaucoup sont toxiques.',
    'Frequent explicit content can create unrealistic expectations about bodies and intimacy, and may contribute to guilt or distress.':
        'La consommation fréquente de contenu explicite peut créer des attentes irréalistes sur le corps et l’intimité, et contribuer à la culpabilité ou au mal-être.',
    'Drinking enough water supports normal physical and mental performance.':
        'Boire suffisamment d’eau favorise des performances physiques et mentales normales.',
    'Regular physical activity supports the heart, muscles, bones, and mental well-being.':
        'Une activité physique régulière soutient le cœur, les muscles, les os et le bien-être mental.',
    'A balanced and varied diet supports energy and helps protect long-term health.':
        'Une alimentation équilibrée et variée soutient l’énergie et contribue à préserver la santé à long terme.',
    'Could not open offline storage':
        'Impossible d’ouvrir le stockage hors ligne',
    'Could not save habit offline':
        'Impossible d’enregistrer l’habitude hors ligne',
    'Retry': 'Réessayer',
    'Welcome to': 'Bienvenue dans',
    'Track your habits visually, build healthier routines, reduce unwanted behaviors with clear plans, and get guidance from AI—all in one place.':
        'Suivez vos habitudes visuellement, développez des routines plus saines, réduisez les comportements indésirables grâce à des plans clairs et bénéficiez des conseils de l’IA, le tout au même endroit.',
    'Next': 'Suivant',
    'Set up later': 'Configurer plus tard',
    'Previous': 'Précédent',
    'Choose language': 'Choisir la langue',
    'App appearance': 'Apparence de l’application',
    'Theme': 'Thème',
    'Choose how the app looks.': 'Choisissez l’apparence de l’application.',
    'Used throughout the app.': 'Utilisé dans toute l’application.',
    'Language used throughout the app.':
        'Langue utilisée dans toute l’application.',
    'Rewards and access': 'Récompenses et accès',
    'Token markers show the cost of optional changes or extended features. Choose tokens or a rewarded ad when offered.':
        'Les marqueurs de jetons indiquent le coût des modifications facultatives ou des fonctions étendues. Choisissez des jetons ou une publicité récompensée lorsqu’elle est proposée.',
    'Badges grow with profile, body, and calendar progress. Completing milestones can award tokens.':
        'Les badges progressent avec le profil, le corps et le calendrier. Atteindre des objectifs peut rapporter des jetons.',
    'Ads': 'Publicités',
    'Rewarded ads are an optional alternative to tokens. Plus includes fewer on-board ads.':
        'Les publicités récompensées sont une alternative facultative aux jetons. Plus contient moins de publicités intégrées.',
    'Free and Plus access': 'Accès Free et Plus',
    'Free includes limited core features. Plus makes core features unlimited, while premium extensions can still require the displayed token amount or an ad.':
        'Free comprend des fonctions principales limitées. Plus rend les fonctions principales illimitées, mais les extensions premium peuvent encore demander le nombre de jetons affiché ou une publicité.',
    'Privacy and policies': 'Confidentialité et politiques',
    'Log out': 'Se déconnecter',
    'Sign out of the account on this device. Local habit data stays on the phone.':
        'Déconnectez le compte sur cet appareil. Les données locales des habitudes restent sur le téléphone.',
    'Log out of this account on this device?':
        'Se déconnecter de ce compte sur cet appareil ?',
    'Logged out': 'Déconnexion effectuée',
    'No signed-in account': 'Aucun compte connecté',
    'Welcome page preview': 'Aperçu des pages de bienvenue',
    'Open the welcome pages without resetting your onboarding progress.':
        'Ouvrez les pages de bienvenue sans réinitialiser votre progression.',
    'Preview welcome pages': 'Voir les pages de bienvenue',
    'Close preview': 'Fermer l’aperçu',
    'Body Progress': 'Progression du corps',
    'Body': 'Corps',
    'Progress': 'Progression',
    'welcome_body_description':
        'Visualisez votre régularité grâce aux couleurs symboliques des organes et des muscles. Explorez les vues du corps, suivez votre progression de mauvaise à excellente et observez comment vos habitudes et entraînements façonnent votre corps visuel.',
    'Gradual title line': 'Réduction',
    'Reduction title line': 'progressive',
    'Choose an unwanted habit and follow a custom hard, medium, or easy calendar that spaces allowed days farther apart over time. Adjust when needed, record honestly, and reduce at a pace you can sustain.':
        'Choisissez une habitude indésirable et suivez un calendrier personnalisé difficile, moyen ou facile qui espace progressivement les jours autorisés. Ajustez-le si nécessaire, notez honnêtement et réduisez à un rythme durable.',
    'Custom title line': 'Graphique',
    'Calendar title line': 'personnalisé',
    'Graph title line': 'personnalisé',
    'Build a personalized calendar graph from up to three habits. Give each success or miss its own positive or negative value, then see all three combine into one line that reveals your progress over time.':
        'Créez un graphique de calendrier personnalisé à partir de trois habitudes maximum. Attribuez une valeur positive ou négative à chaque réussite ou oubli, puis observez les trois se combiner en une ligne révélant votre progression.',
    'More title line': 'Plus de',
    'Features title line': 'fonctionnalités',
    'Stay motivated with calendars, streaks, badges, reminders, and weekly insights. Personalize your experience and get helpful AI guidance as Visual You grows with you.':
        'Restez motivé grâce aux calendriers, séries, badges, rappels et bilans hebdomadaires. Personnalisez votre expérience et profitez des conseils utiles de l’IA à mesure que Visual You évolue avec vous.',
    'Create title line': 'Créer un',
    'Account title line': 'compte',
    'Sign up with email': 'S’inscrire par e-mail',
    'Continue with Google': 'Continuer avec Google',
    'Continue with Apple': 'Continuer avec Apple',
    'Already have an account?': 'Vous avez déjà un compte ?',
    'Log in': 'Se connecter',
    'Create account': 'Créer un compte',
    'Verify your email': 'Vérifiez votre e-mail',
    'Create a password': 'Créez un mot de passe',
    'We will email you a six-digit verification code.':
        'Nous vous enverrons un code de vérification à six chiffres.',
    'Enter the code sent to your email. It expires in 10 minutes.':
        'Saisissez le code envoyé par e-mail. Il expire dans 10 minutes.',
    'Your email is verified. Create a secure password to finish.':
        'Votre e-mail est vérifié. Créez un mot de passe sécurisé pour terminer.',
    'Enter a valid email address': 'Saisissez une adresse e-mail valide',
    'Enter the six-digit code': 'Saisissez le code à six chiffres',
    'Passwords do not match': 'Les mots de passe ne correspondent pas',
    'Continue': 'Continuer',
    'Email address': 'Adresse e-mail',
    'Verification code': 'Code de vérification',
    'Password': 'Mot de passe',
    'Confirm password': 'Confirmer le mot de passe',
    'Your account is ready': 'Votre compte est prêt',
    'Enter your email and password.':
        'Saisissez votre e-mail et votre mot de passe.',
    'Signed in': 'Connexion réussie',
    'Almost done': 'Presque terminé',
    'Date of birth': 'Date de naissance',
    'Day': 'Jour',
    'Month': 'Mois',
    'Year': 'Année',
    'Complete your name and date of birth':
        'Indiquez votre nom et votre date de naissance',
    'Add profile picture': 'Ajouter une photo de profil',
    'Change profile picture': 'Changer la photo de profil',
    'Could not open your photos': 'Impossible d’ouvrir vos photos',
    'Choose new picture': 'Choisir une autre photo',
    'Adjust picture position': 'Ajuster la position de la photo',
    'Remove picture': 'Supprimer la photo',
    'Picture position': 'Position de la photo',
    'Horizontal position': 'Position horizontale',
    'Vertical position': 'Position verticale',
    'Drag the picture to position it inside the circle':
        'Faites glisser la photo pour la placer dans le cercle',
    'Pinch with two fingers to zoom': 'Pincez avec deux doigts pour zoomer',
    'Before you begin': 'Avant de commencer',
    'Please read and acknowledge these important notes about using Visual You.':
        'Veuillez lire et reconnaître ces remarques importantes concernant l’utilisation de Visual You.',
    'Track honestly and consistently': 'Suivez vos habitudes avec honnêteté',
    'agreement_honesty_note':
        'Soyez honnête avec vous-même et notez vos habitudes régulièrement, même lors des journées difficiles. Évitez de sauter des entrées et suivez les plans de réduction avec patience et discipline. Un suivi précis rend votre progression plus significative.',
    'Understand symbolic progress': 'Comprenez la progression symbolique',
    'agreement_symbolic_note':
        'Les couleurs du corps, des muscles et des organes sont des indicateurs symboliques de progression. Elles changent lorsque des points d’habitude sont ajoutés ou retirés d’un niveau moyen neutre et ne diagnostiquent, ne mesurent ni ne représentent l’état médical réel d’un organe ou d’une partie du corps. Les calendriers de réduction sont uniquement des guides facultatifs de changement de comportement ; vous pouvez les suspendre, manquer des jours ou les adapter à vos besoins.',
    'I agree to the terms and policies':
        'J’accepte les conditions et les politiques',
    'Please accept the terms and policies to continue':
        'Acceptez les conditions et les politiques pour continuer',
    'Done': 'Terminé',
  },
  'uz': {
    'Body statistics': 'Tana statistikasi',
    'Calendar': 'Taqvim',
    'Previous month': 'Oldingi oy',
    'Next month': 'Keyingi oy',
    'Terrible': 'Juda yomon',
    'OK': 'Qoniqarli',
    'Excellent': 'A’lo',
    'No habits logged': 'Odatlar qayd etilmagan',
    'What you did': 'Nima qildingiz',
    'Habits I did': 'Men bajargan odatlar',
    "What I didn't do": 'Men bajarmagan odatlar',
    'Gradual reduction': 'Asta-sekin kamaytirish',
    'Create plan': 'Reja yaratish',
    'Create reduction plan': 'Kamaytirish rejasini yaratish',
    'Second reduction plan': 'Ikkinchi kamaytirish rejasi',
    'Change reduction plan': 'Kamaytirish rejasini o‘zgartirish',
    'Start date': 'Boshlanish sanasi',
    'Choose tracker start date': 'Boshlanish sanasini tanlang',
    'Did you do this habit?': 'Bu odatni bajardingizmi?',
    'I did not': 'Bajarmadim',
    'Starts with five allowed days, then reduces gradually with longer repeated cycles.':
        'Besh ruxsat etilgan kundan boshlanadi, keyin uzunroq takroriy sikllar bilan asta-sekin kamayadi.',
    'Scheduled days are planned maximum-use checkpoints. Skipping or changing them is always okay.':
        'Rejalashtirilgan kunlar odatni bajarishning eng yuqori chegaralaridir. Ularni o‘tkazib yuborish yoki o‘zgartirish mumkin.',
    'Change plan': 'Rejani o‘zgartirish',
    'Choose unwanted habit': 'Keraksiz odatni tanlang',
    'No unwanted habits available': 'Keraksiz odatlar mavjud emas',
    'Quit method': 'Tashlash usuli',
    'Hard': 'Qiyin',
    'Medium': 'O‘rta',
    'Easy': 'Oson',
    'Coming later': 'Keyinroq qo‘shiladi',
    'Start plan': 'Rejani boshlash',
    'Stay free': 'Odatdan xoli',
    'Scheduled day': 'Rejalashtirilgan kun',
    'Off-plan use': 'Rejadan tashqari',
    'Create a custom calendar that spaces an unwanted habit farther apart over time.':
        'Keraksiz odat orasidagi vaqtni asta-sekin uzaytiradigan taqvim yarating.',
    'Starts today, then spaces checkpoints by 2, 3, 4, 5 days and progressively farther apart.':
        'Bugun boshlanadi, keyin oraliqlar 2, 3, 4, 5 kun bo‘lib tobora uzayadi.',
    'Repeats each gap as many times as its day number, with allowed windows that become smaller again at long intervals.':
        'Har bir oraliq kunlar sonicha takrorlanadi, uzoq oraliqlarda ruxsat etilgan kunlar yana kamayadi.',
    'Dark circles are planned maximum-use checkpoints. Skipping them is always okay.':
        'To‘q doiralar rejalashtirilgan eng yuqori foydalanish nuqtalari. Ularni o‘tkazib yuborish mumkin.',
    'If you may be dependent on alcohol, reducing or stopping suddenly can be dangerous. Seek medical support.':
        'Alkogolga qaramlik bo‘lishi mumkin bo‘lsa, birdan kamaytirish yoki to‘xtatish xavfli. Tibbiy yordam oling.',
    'AI coach': 'AI murabbiy',
    'Open profile': 'Profilni ochish',
    'Settings': 'Sozlamalar',
    'Home': 'Bosh sahifa',
    'Add habit': 'Odat qo‘shish',
    'Close': 'Yopish',
    'Hi!': 'Salom!',
    'Let\'s build a better you': 'Keling, o‘zingizni yanada yaxshilang',
    'Quick add': 'Tezkor qo‘shish',
    'Water': 'Suv',
    'Healthy meal': 'Sog‘lom ovqat',
    'Arm workout': 'Qo‘l mashqi',
    'Abs workout': 'Qorin mashqi',
    'Smoke-free': 'Chekishsiz',
    'Consuming sugar': 'Shakar iste’mol qilish',
    'Alcohol': 'Alkogol',
    'Add a habit': 'Odat qo‘shish',
    'Good habits': 'Yaxshi odatlar ✨',
    'Drinking water': 'Suv ichish',
    'Eating healthy': 'Sog‘lom ovqatlanish',
    'Exercises': 'Mashqlar',
    'Bad habits': 'Yomon odatlar ❌',
    'Smoking': 'Chekish',
    'Vaping': 'Veyp ishlatish',
    'Unhealthy eating': 'Nosog‘lom ovqatlanish',
    'Adult videos': 'Kattalar videolari',
    'Masturbation': 'Masturbatsiya',
    'Arm': 'Qo‘l',
    'Shoulder / Back': 'Yelka / Orqa',
    'Chest': 'Ko‘krak',
    'Abs': 'Qorin',
    'Legs': 'Oyoqlar',
    'I did': 'Bajardim',
    'Back': 'Orqaga',
    'Edit profile': 'Profilni tahrirlash',
    'Your Name': 'Ismingiz',
    'Gender': 'Jins',
    'Age': 'Yosh',
    'Not set': 'Kiritilmagan',
    'Name': 'Ism',
    'Male': 'Erkak',
    'Female': 'Ayol',
    'Cancel': 'Bekor qilish',
    'I did this habit': 'Bu odatni bajardim',
    'I missed this habit': 'Bu odatni bajarmadim',
    'I avoided this habit': 'Bu odatdan tiyildim',
    'Habit status saved': 'Odat holati saqlandi',
    'Change this reduction plan?': 'Bu kamaytirish rejasi o‘zgartirilsinmi?',
    'Changing it will replace this habit’s current schedule and start date.':
        'O‘zgartirish bu odatning joriy jadvali va boshlanish sanasini almashtiradi.',
    'Edit habits': 'Odatlarni tahrirlash',
    'Edit habit': 'Odatni tahrirlash',
    'Finish editing': 'Tahrirlashni tugatish',
    'Use the star for Quick Add. Remove or restore habits with the button beside it.':
        'Tezkor qo‘shish uchun yulduzchadan foydalaning. Yonidagi tugma odatni olib tashlaydi yoki tiklaydi.',
    'Remove from Quick Add': 'Tezkor qo‘shishdan olib tashlash',
    'Add to Quick Add': 'Tezkor qo‘shishga kiritish',
    'Remove habit': 'Odatni olib tashlash',
    'Restore habit': 'Odatni tiklash',
    'Choose Quick Add favorites with the pen on the add-habits page.':
        'Tezkor odatlarni odat qo‘shish sahifasidagi qalam orqali tanlang.',
    'Save': 'Saqlash',
    'Enter an age from 1 to 120': '1 dan 120 gacha yosh kiriting',
    'Appearance': 'Ko‘rinish',
    'Choose how VisualYou looks. Your choice applies throughout the app.':
        'VisualYou ko‘rinishini tanlang. Tanlov butun ilovaga qo‘llanadi.',
    'Light': 'Yorug‘',
    'System': 'Tizim',
    'Dark': 'Qorong‘i',
    'Color theme': 'Rang mavzusi',
    'This accent color is used across VisualYou.':
        'Bu rang butun VisualYou bo‘ylab ishlatiladi.',
    'Blue': 'Ko‘k',
    'Pink': 'Pushti',
    'Choose the body displayed on Home and Body Statistics.':
        'Bosh sahifa va tana statistikasida ko‘rsatiladigan tanani tanlang.',
    'Language': 'Til',
    'Choose the language used throughout VisualYou.':
        'VisualYou bo‘ylab ishlatiladigan tilni tanlang.',
    'English': 'Inglizcha',
    'Spanish': 'Ispancha',
    'Russian': 'Ruscha',
    'French': 'Fransuzcha',
    'Uzbek': 'O‘zbekcha',
    'Show organs': 'Organlarni ko‘rsatish',
    'Show muscles': 'Mushaklarni ko‘rsatish',
    'Performance': 'Natija',
    'Bad': 'Yomon',
    'Good': 'Yaxshi',
    'Custom graph': 'Asosiy grafik',
    'Customize graph': 'Grafikni sozlash',
    'Could not load custom graph': 'Grafikni yuklab bo‘lmadi',
    'Choose up to 3 habits and set their point values.':
        '3 tagacha odat tanlang va ballarini belgilang.',
    'Habit': 'Odat',
    'Choose habit': 'Odatni tanlash',
    'Not selected': 'Tanlanmagan',
    'If completed': 'Bajarilsa',
    'If missed': 'Bajarilmasa',
    'Points ': 'Ball ',
    'Save graph': 'Grafikni saqlash',
    'Choose different habits.': 'Turli odatlarni tanlang.',
    'Enter valid whole numbers.': 'To‘g‘ri butun sonlarni kiriting.',
    'Could not save custom graph': 'Grafikni saqlab bo‘lmadi',
    'Choose up to 3 habits': '3 tagacha odat tanlang',
    'Set up graph': 'Grafikni sozlash',
    'Choose special habit': 'Maxsus odatni tanlash',
    'Useful information': 'Foydali ma’lumot',
    'Breathing': 'Nafas olish',
    'Inhale': 'Nafas oling',
    'Exhale': 'Nafas chiqaring',
    'Hold': 'Ushlab turing',
    'Take a calm breath': 'Tinch nafas oling',
    'Pause breathing': 'Nafas mashqini pauza qilish',
    'Start breathing': 'Nafas mashqini boshlash',
    'Breathe after a good habit to link each breath with that positive feeling. Before an unwanted habit, breathe to pause, think, and remember how good your better choice felt.':
        'Yaxshi odatdan keyin nafas olib, har bir nafasni shu ijobiy tuyg‘u bilan bog‘lang. Keraksiz odatdan oldin esa to‘xtab, o‘ylash va yaxshi tanlovdagi yoqimli tuyg‘uni eslash uchun nafas oling.',
    'Alcohol can affect many organs and may also strain relationships and friendships.':
        'Alkogol ko‘plab a’zolarga ta’sir qilishi, shuningdek munosabatlar va do‘stlikka zarar yetkazishi mumkin.',
    'Cigarette smoke contains more than 7,000 chemicals, including many that are toxic.':
        'Sigaret tutunida 7 000 dan ortiq kimyoviy modda bor va ularning ko‘pi zaharli.',
    'Frequent explicit content can create unrealistic expectations about bodies and intimacy, and may contribute to guilt or distress.':
        'Ochiq kontentni tez-tez ko‘rish tana va yaqinlik haqida noto‘g‘ri kutilmalar yaratishi, aybdorlik yoki bezovtalikka sabab bo‘lishi mumkin.',
    'Drinking enough water supports normal physical and mental performance.':
        'Yetarli suv ichish jismoniy va aqliy faoliyatni qo‘llab-quvvatlaydi.',
    'Regular physical activity supports the heart, muscles, bones, and mental well-being.':
        'Muntazam jismoniy faollik yurak, mushaklar, suyaklar va ruhiy holatni qo‘llab-quvvatlaydi.',
    'A balanced and varied diet supports energy and helps protect long-term health.':
        'Muvozanatli va xilma-xil ovqatlanish energiya beradi va uzoq muddatli salomatlikni qo‘llab-quvvatlaydi.',
    'Could not open offline storage': 'Oflayn xotirani ochib bo‘lmadi',
    'Could not save habit offline': 'Odatni oflayn saqlab bo‘lmadi',
    'Retry': 'Qayta urinish',
    'Welcome to': 'Xush kelibsiz',
    'Track your habits visually, build healthier routines, reduce unwanted behaviors with clear plans, and get guidance from AI—all in one place.':
        'Odatlaringizni vizual kuzating, sog‘lom odatlarni rivojlantiring, keraksiz xatti-harakatlarni aniq rejalar bilan kamaytiring va sun’iy intellekt yordamidan foydalaning — barchasi bir joyda.',
    'Next': 'Keyingi',
    'Set up later': 'Keyinroq sozlash',
    'Previous': 'Oldingi',
    'Choose language': 'Tilni tanlash',
    'App appearance': 'Ilova ko‘rinishi',
    'Theme': 'Mavzu',
    'Choose how the app looks.': 'Ilova qanday ko‘rinishini tanlang.',
    'Used throughout the app.': 'Butun ilovada ishlatiladi.',
    'Language used throughout the app.': 'Butun ilovada ishlatiladigan til.',
    'Rewards and access': 'Mukofotlar va kirish',
    'Token markers show the cost of optional changes or extended features. Choose tokens or a rewarded ad when offered.':
        'Token belgisi ixtiyoriy o‘zgarish yoki kengaytirilgan imkoniyat narxini ko‘rsatadi. Taklif qilinganda token yoki mukofotli reklamani tanlang.',
    'Badges grow with profile, body, and calendar progress. Completing milestones can award tokens.':
        'Nishonlar profil, tana va taqvim taraqqiyoti bilan rivojlanadi. Maqsadlarni bajarish token berishi mumkin.',
    'Ads': 'Reklamalar',
    'Rewarded ads are an optional alternative to tokens. Plus includes fewer on-board ads.':
        'Mukofotli reklamalar tokenlarga ixtiyoriy muqobildir. Plus ichki reklamalarni kamaytiradi.',
    'Free and Plus access': 'Free va Plus kirishi',
    'Free includes limited core features. Plus makes core features unlimited, while premium extensions can still require the displayed token amount or an ad.':
        'Free cheklangan asosiy imkoniyatlarni o‘z ichiga oladi. Plus asosiy imkoniyatlarni cheksiz qiladi, ammo premium kengaytmalar ko‘rsatilgan token miqdori yoki reklamani talab qilishi mumkin.',
    'Privacy and policies': 'Maxfiylik va siyosatlar',
    'Log out': 'Hisobdan chiqish',
    'Sign out of the account on this device. Local habit data stays on the phone.':
        'Ushbu qurilmadagi hisobdan chiqing. Mahalliy odat ma’lumotlari telefonda qoladi.',
    'Log out of this account on this device?':
        'Ushbu qurilmadagi hisobdan chiqilsinmi?',
    'Logged out': 'Hisobdan chiqildi',
    'No signed-in account': 'Kirilgan hisob yo‘q',
    'Welcome page preview': 'Xush kelibsiz sahifalari ko‘rinishi',
    'Open the welcome pages without resetting your onboarding progress.':
        'Boshlang‘ich sozlash jarayonini qayta tiklamasdan xush kelibsiz sahifalarini oching.',
    'Preview welcome pages': 'Xush kelibsiz sahifalarini ko‘rish',
    'Close preview': 'Ko‘rishni yopish',
    'Body Progress': 'Tana rivoji',
    'Body': 'Tana',
    'Progress': 'Rivoj',
    'welcome_body_description':
        'Izchilligingizni a’zolar va mushaklarning ramziy ranglari orqali kuzating. Tana ko‘rinishlarini o‘rganing, yomon holatdan a’lo holatgacha bo‘lgan rivojni kuzating hamda odatlar va mashqlar vizual tanangizni qanday shakllantirishini ko‘ring.',
    'Gradual title line': 'Asta-sekin',
    'Reduction title line': 'kamaytirish',
    'Choose an unwanted habit and follow a custom hard, medium, or easy calendar that spaces allowed days farther apart over time. Adjust when needed, record honestly, and reduce at a pace you can sustain.':
        'Keraksiz odatni tanlang va ruxsat etilgan kunlar orasini vaqt o‘tishi bilan uzaytiradigan shaxsiy qiyin, o‘rta yoki oson kalendarga amal qiling. Zarur bo‘lsa rejani moslang, halol qayd eting va barqaror sur’atda kamaytiring.',
    'Custom title line': 'Maxsus',
    'Calendar title line': 'kalendar',
    'Graph title line': 'grafik',
    'Build a personalized calendar graph from up to three habits. Give each success or miss its own positive or negative value, then see all three combine into one line that reveals your progress over time.':
        'Uchtagacha odatdan shaxsiy kalendar grafigini yarating. Har bir muvaffaqiyat yoki o‘tkazib yuborishga ijobiy yoki salbiy qiymat bering va ularning vaqt davomida rivojingizni ko‘rsatadigan yagona chiziqqa birlashishini kuzating.',
    'More title line': 'Ko‘proq',
    'Features title line': 'imkoniyatlar',
    'Stay motivated with calendars, streaks, badges, reminders, and weekly insights. Personalize your experience and get helpful AI guidance as Visual You grows with you.':
        'Kalendarlar, ketma-ketliklar, nishonlar, eslatmalar va haftalik natijalar bilan motivatsiyani saqlang. Tajribangizni moslashtiring va Visual You siz bilan birga rivojlanar ekan, foydali sun’iy intellekt tavsiyalarini oling.',
    'Create title line': 'Hisob',
    'Account title line': 'yarating',
    'Sign up with email': 'Email orqali ro‘yxatdan o‘tish',
    'Continue with Google': 'Google orqali davom etish',
    'Continue with Apple': 'Apple orqali davom etish',
    'Already have an account?': 'Hisobingiz bormi?',
    'Log in': 'Kirish',
    'Create account': 'Hisob yaratish',
    'Verify your email': 'Emailingizni tasdiqlang',
    'Create a password': 'Parol yarating',
    'We will email you a six-digit verification code.':
        'Emailingizga olti xonali tasdiqlash kodini yuboramiz.',
    'Enter the code sent to your email. It expires in 10 minutes.':
        'Emailingizga yuborilgan kodni kiriting. U 10 daqiqada tugaydi.',
    'Your email is verified. Create a secure password to finish.':
        'Emailingiz tasdiqlandi. Yakunlash uchun xavfsiz parol yarating.',
    'Enter a valid email address': 'To‘g‘ri email manzilini kiriting',
    'Enter the six-digit code': 'Olti xonali kodni kiriting',
    'Passwords do not match': 'Parollar mos kelmadi',
    'Continue': 'Davom etish',
    'Email address': 'Email manzili',
    'Verification code': 'Tasdiqlash kodi',
    'Password': 'Parol',
    'Confirm password': 'Parolni tasdiqlang',
    'Your account is ready': 'Hisobingiz tayyor',
    'Enter your email and password.': 'Email va parolingizni kiriting.',
    'Signed in': 'Hisobga kirildi',
    'Almost done': 'Deyarli tayyor',
    'Date of birth': 'Tug‘ilgan sana',
    'Day': 'Kun',
    'Month': 'Oy',
    'Year': 'Yil',
    'Complete your name and date of birth':
        'Ismingiz va tug‘ilgan sanangizni kiriting',
    'Add profile picture': 'Profil rasmini qo‘shish',
    'Change profile picture': 'Profil rasmini o‘zgartirish',
    'Could not open your photos': 'Rasmlaringizni ochib bo‘lmadi',
    'Choose new picture': 'Boshqa rasmni tanlash',
    'Adjust picture position': 'Rasm joylashuvini sozlash',
    'Remove picture': 'Rasmni olib tashlash',
    'Picture position': 'Rasm joylashuvi',
    'Horizontal position': 'Gorizontal joylashuv',
    'Vertical position': 'Vertikal joylashuv',
    'Drag the picture to position it inside the circle':
        'Rasmni doira ichida joylashtirish uchun suring',
    'Pinch with two fingers to zoom':
        'Kattalashtirish uchun ikki barmoq bilan qisib suring',
    'Before you begin': 'Boshlashdan oldin',
    'Please read and acknowledge these important notes about using Visual You.':
        'Visual You’dan foydalanish haqidagi ushbu muhim eslatmalarni o‘qing va tasdiqlang.',
    'Track honestly and consistently': 'Halol va muntazam qayd eting',
    'agreement_honesty_note':
        'O‘zingizga nisbatan halol bo‘ling va qiyin kunlarda ham odatlaringizni muntazam qayd eting. Qaydlarni o‘tkazib yubormaslikka harakat qiling hamda kamaytirish rejalariga sabr va intizom bilan amal qiling. Aniq qaydlar rivojingizni yanada mazmunli qiladi.',
    'Understand symbolic progress': 'Ramziy rivojni to‘g‘ri tushuning',
    'agreement_symbolic_note':
        'Tana, mushak va a’zolar ranglari rivojning ramziy ko‘rsatkichlaridir. Ular odat ballarini neytral o‘rtacha bosqichga qo‘shish yoki undan ayirish orqali o‘zgaradi va hech bir a’zo yoki tana qismining haqiqiy tibbiy holatini aniqlamaydi, o‘lchamaydi yoki ifodalamaydi. Kamaytirish kalendarlari faqat ixtiyoriy xulq-atvor qo‘llanmasidir; ularni to‘xtatish, kunlarni o‘tkazib yuborish yoki ehtiyojingizga ko‘ra o‘zgartirish mumkin.',
    'I agree to the terms and policies': 'Shartlar va siyosatlarga roziman',
    'Please accept the terms and policies to continue':
        'Davom etish uchun shartlar va siyosatlarni qabul qiling',
    'Done': 'Tayyor',
  },
};
