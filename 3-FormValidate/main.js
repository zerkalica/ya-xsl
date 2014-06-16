(function (window, document) {
  window.App = {};

  var getElements = function (selector, target) {
    target = target || document;
    return Array.prototype.slice.call(target.querySelectorAll(selector));
  };

  var prepareConstraint = function (constraint) {
    return constraint
      .replace(/\./g, 'value')
      .replace(/([\w]+)\-([\w]+)/gi, '$1_$2');
  };

  var executeConstraint = function (constraint, value) {
    var result;

    var string_length = function (value) {
      return value.length;
    };

    try {
      // По условию задачи данные хранятся в XForms, валидация хранится в виде expressions, в XForms bind/constraints
      // Это попытка приближенно адаптировать выражения xforms для js.
      // Constraint в XForms лучше не использовать из-за бедных возможностей.
      // Eval используется, т.к. xforms constraint не позволяют задать правила более формально, что бы полностью отделить данные от кода
      result = eval(prepareConstraint(constraint));
    } catch (e) {
      if (e instanceof SyntaxError) {
        alert(e.message);
      }
    }

    return result;
  };

  var validateElement = function (el) {
    var result,
        constraint,
        data = el.dataset;

    if (data.constraint) {
      result = executeConstraint(data.constraint, el.value);
      console.log(result);
    }

    return (!result && data.error) ? data.error : '';
  };

  App.attachValidator = function (selector) {
    getElements(selector).forEach(function (xForm) {
      var button = xForm.querySelector('.xform-submit');
      button.addEventListener('click', function (e) {
        e.preventDefault();
        getElements('.xform-element-wrapper', xForm).forEach(function (xFormElement) {
          var el, errorMessage;
          el = xFormElement.querySelector('.xform-validatable-element');
          if (el) {
            errorMessage = validateElement(el);
            xFormElement.querySelector('.xform-validatable-error-placeholder').innerHTML = errorMessage;
          }
        });
      });
    });
  };

})(window, document);
