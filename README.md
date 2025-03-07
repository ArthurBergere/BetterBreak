# **Wellness App - Documentation Technique**

## 📌 **Présentation du projet**
**Nom de l'application :** Wellness App  
**Objectif :** Offrir une expérience de bien-être numérique en combinant des moments de relaxation et une gestion responsable du temps passé sur les réseaux sociaux. L’application permet aux utilisateurs de fixer des limites d’utilisation des réseaux sociaux et d’accéder à un espace de bien-être avec des messages motivants.

## 🎯 **Fonctionnalités principales**
1. **Accueil (Home)**
   - Affichage du titre "Wellness".
   - Un bouton central : "Débuter mes 5 minutes wellness du jour".
   - Au clic, des phrases de motivation apparaissent progressivement avec un effet de fade-in/fade-out en rythme avec une respiration lente.

2. **Navigation (Navbar - Bottom Navigation Bar)**
   - Permet de naviguer entre les différentes pages de l'application.
   - Pages accessibles : Accueil, Réseaux sociaux, Paramètres.

3. **Page Réseaux Sociaux**
   - Intègre un navigateur Web (`webview_flutter`).
   - Icônes en haut permettant de basculer entre **Instagram, Twitter et LinkedIn**.
   - Implémentation d’un "Social Burst Time Limit" permettant de **restreindre l'accès aux réseaux sociaux** après un temps défini.
   - Blocage automatique de l'accès aux réseaux sociaux une fois le temps imparti écoulé.

4. **Page Paramètres**
   - Définir la durée autorisée d'utilisation des réseaux sociaux par session (entre 2 et 10 minutes, par défaut 10 min).
   - Sélectionner des tranches horaires où l'utilisateur est autorisé à accéder aux réseaux sociaux.
   - Sauvegarde des préférences avec `shared_preferences` pour persistance.

## 🏗 **Architecture du projet**

📂 **/lib**  
├── 📂 **models**  
│   ├── `user_settings.dart` (Classe pour gérer les préférences utilisateur avec `SharedPreferences`)  
│
├── 📂 **pages**  
│   ├── `home_page.dart` (Page principale avec le bouton Wellness)  
│   ├── `social_page.dart` (Page des réseaux sociaux avec WebView et gestion du temps d'accès)  
│   ├── `settings_page.dart` (Page pour configurer les limites d'utilisation des réseaux sociaux)  
│
├── 📂 **widgets**  
│   ├── `bottom_navbar.dart` (Barre de navigation commune à toutes les pages)  
│
├── `main.dart` (Fichier principal, initialise l'application et la navigation)  

## 🛠 **Technologies et Packages utilisés**
- **Flutter** (Framework principal)
- **Dart** (Langage de programmation)
- **webview_flutter** (Affichage des pages Web des réseaux sociaux)
- **shared_preferences** (Stockage local des préférences utilisateur)
- **provider** (Gestion d'état si nécessaire)

## 📌 **Améliorations futures possibles**
- Ajouter une fonctionnalité de statistiques sur l'utilisation des réseaux sociaux.
- Implémenter un mode "Relaxation avancée" avec des animations plus immersives.
- Ajouter une authentification pour synchroniser les préférences sur plusieurs appareils.

## 👨‍💻 **Instructions pour le développement**
1. **Cloner le projet**
   ```sh
   git clone https://github.com/nom_du_repo.git
   cd wellness_app
   ```
2. **Installer les dépendances**
   ```sh
   flutter pub get
   ```
3. **Lancer l'application**
   ```sh
   flutter run
   ```

---



