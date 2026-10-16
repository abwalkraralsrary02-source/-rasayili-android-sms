# دليل بناء وتشغيل تطبيق "رسائلي" (My Messages) لنظام Android

تطبيق أصلي متكامل ومفتوح المصدر مبني باستخدام **Kotlin** و **Jetpack Compose**، يعمل بدون إنترنت معتمداً كلياً على شريحة الهاتف الخلوية (SIM Card) ومزود رسائل النظام **Telephony ContentProvider**.

---

## 1. المتطلبات الأساسية
- **نظام التشغيل المدعوم**: Android 9.0 (API 28 - Pie) وما بعده حتى Android 15 (API 35).
- **الذاكرة العشوائية**: محسّن للعمل بسلاسة فائقة حتى على الهواتف الاقتصادية بذاكرة **2GB RAM**.
- **أدوات البناء**:
  - Android Studio (Hedgehog, Ladybug أو أحدث)
  - JDK 17
  - Android SDK Platform 35 و SDK Build-Tools 35.0.0

---

## 2. خطوات البناء والتثبيت

### الطريقة الأولى: عبر سطر الأوامر (Command Line)
```bash
# 1. التوجه لمجلد المشروع
cd android

# 2. منح صلاحية التنفيذ لـ Gradle Wrapper (على Linux / macOS)
chmod +x gradlew

# 3. بناء نسخة تصحيح الأخطاء (Debug APK)
./gradlew assembleDebug

# 4. تثبيت التطبيق على الهاتف المتصل بـ USB مع تفعيل USB Debugging
adb install -r app/build/outputs/apk/debug/app-debug.apk
```

### الطريقة الثانية: عبر Android Studio
1. افتح Android Studio واختر **Open** ثم حدد المجلد `android`.
2. انتظر مزامنة Gradle (Gradle Sync).
3. اختر جهازك الحقيقي أو محاكي أندرويد واضغط على **Run (Shift + F10)**.

---

## 3. اختبار رسائل SMS على محاكي Android Emulator
يمكنك إرسال رسائل SMS تجريبية إلى المحاكي عبر منفذ Telnet أو لوحة تحكم المحاكي:
1. انقر على النقاط الثلاث (...) في قائمة المحاكي الجانبية.
2. اختر قسم **Cellular / Phone**.
3. اكتب الرقم ونص الرسالة واضغط **Send Message**.
4. سيستقبل التطبيق رسالة حقيقية عبر `SmsReceiver` ويظهر إشعار فوري.

---

## 4. قيود أندرويد الأمنية (Android Architecture & Security Notes)
1. **تطبيق SMS الافتراضي**: بدءاً من أندرويد 4.4 (KitKat) ومروراً بـ أندرويد 9 و 14، يتطلب النظام تعيين التطبيق كتطبيق SMS افتراضي حتى يتمكن من استقبال `SMS_DELIVER_ACTION` وحذف الرسائل من مزود النظام المشترك.
2. **الخصوصية التامة**: تم تعمد **عدم طلب إذن الإنترنت** (`android.permission.INTERNET`) في `AndroidManifest.xml` لضمان عدم تسريب أي بيانات إلى أي خادم خارجي.
3. **أجهزة 2GB RAM**: تم استخدام `LazyColumn` مع مفاتيح فريدة (`key = { it.id }`) وتجنب استهلاك الذاكرة في الرسوميات لضمان أداء مستقر وموفر للبطارية.