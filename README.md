Тестовое задание по XSL
=======================

Для работы требуется установленный xsltproc. Тестировалось в ОС Ubuntu 14.04 LTS.


Общая структура всех проектов
-----------------------------

* run.sh                    - shell скрипт для запуска преобразований
* data.xml, *-data.xml      - исходные данные
* data.rng                  - схемы RelaxNg для проверки исходных данных
* format.xsl                - основной файл с преобразованиями
* output*.html, output*.xml - результат выполнения преобразования


1-FormNotify
------------

Объявления на формах.


2-CDCatalog
-----------

Обработка данных.


3-FormValidate
--------------

Построение и валидация параметров формы.

* variables.xsl         - общие переменные
* submit-data.xsl       - данные submit а формы
* validation.xsl        - преобразования для валидации (часть 'б', задания)
* format.xsl            - преобразования в html форму
* output-validation.xml - результаты валидации
* output.html           - результаты преобразования XForms формы в html
* main.js               - валидация форм по нажатию кнопки в html-форме
* form-data.xml         - XForms представление формы, XForms данные по-умолчанию

Правила проверки значений формы я решил хранить в XForms/Constraints (http://www.w3.org/TR/2002/WD-xforms-20020118/slice6.html#model-using). Поэтому в main.js я сделал преобразование выражений XPath через regexp к js-коду с последующим eval. Это не лучшее решение, но т.к. не хотелось писать отдельные правила для js и, по условию задачи, формы должны быть в формате XForms, то я оставил все как есть.

4-Menu
------

Генерация меню.
