# Find Route

Проект "Find Route" создан для изучения использования MapKit с использованием UIKit в iOS-приложениях. Приложение предоставляет функциональность по построению кратчайшего маршрута через три заданные точки, решая задачу Коммивояжера.

## Описание проекта

Цель проекта - овладение основами работы с MapKit вместе с UIKit для создания приложения, которое может строить оптимальный маршрут через заданные точки. Пользователи могут добавлять точки на карту, а затем строить кратчайший маршрут, проходящий через все добавленные точки.

## Изученные концепции

- Использование MapKit для отображения карты и работы с географическими данными.
- Создание маркеров на карте с использованием MKAnnotation и MKPointAnnotation.
- Работа с функционалом построения маршрута через заданные точки.
- Работа с элементами интерфейса пользователя, такими как кнопки и алерты.

## Функциональность

Проект "Find Route" предоставляет следующую функциональность:

- **Добавление точек:**
  - Нажмите кнопку "Add", чтобы добавить новую точку на карту.
  - Новые точки отображаются в виде маркеров.

<div>
  <img src="Assets/1.png" alt="01" height="450" style="margin-right: 30px;">
  <img src="Assets/2.png" alt="01" height="450" style="margin-right: 30px;">
  <img src="Assets/3.png" alt="02" height="450">
</div>

<div>
  <img src="Assets/4.png" alt="01" height="450" style="margin-right: 30px;">
  <img src="Assets/5.png" alt="01" height="450" style="margin-right: 30px;">
  <img src="Assets/6.png" alt="02" height="450">
</div>

- **Построение маршрута:**
  - После добавления трех точек появляются кнопки "Route" и "Reset".
  - Нажмите "Route", чтобы построить кратчайший маршрут через все добавленные точки.
  - Кратчайший маршрут отображается на карте.

<div>
  <img src="Assets/7.png" alt="01" height="500" style="margin-right: 30px;">
  <img src="Assets/8.png" alt="02" height="500">
</div>

- **Очистка карты:**
  - Нажмите "Reset", чтобы удалить маршрут и все добавленные точки на карте.

<div>
  <img src="Assets/8.png" alt="01" height="500" style="margin-right: 30px;">
  <img src="Assets/9.png" alt="02" height="500">
</div>

## Запуск проекта

Для запуска проекта выполните следующие шаги:

1. Откройте проект в Xcode.
2. Убедитесь, что ViewController.swift выбран как основной контроллер интерфейса.
3. Запустите симулятор, выбрав устройство для запуска.
4. Интерфейс приложения "Find Route" с картой и функционалом построения маршрута будет отображен на экране.
