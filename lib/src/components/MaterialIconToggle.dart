part of mdlcomponents;

/// Store strings for class names defined by this component that are used in
/// Dart. This allows us to simply change it in one place should we
/// decide to modify at a later date.
class _MaterialIconToggleCssClasses {

    final String INPUT = 'mdl-icon-toggle__input';
    final String JS_RIPPLE_EFFECT = 'mdl-js-ripple-effect';
    final String RIPPLE_IGNORE_EVENTS = 'mdl-js-ripple-effect--ignore-events';
    final String RIPPLE_CONTAINER = 'mdl-icon-toggle__ripple-container';
    final String RIPPLE_CENTER = 'mdl-ripple--center';
    final String RIPPLE = 'mdl-ripple';
    final String IS_FOCUSED = 'is-focused';
    final String IS_DISABLED = 'is-disabled';
    final String IS_CHECKED = 'is-checked';
    final String IS_UPGRADED = 'is-upgraded';


    const _MaterialIconToggleCssClasses();
}

/// Store constants in one place so they can be updated easily.
class _MaterialIconToggleConstant {

    final int TINY_TIMEOUT_IN_MS = 100;

    const _MaterialIconToggleConstant();
}

/// creates MdlConfig for IconToggle
MdlConfig materialIconToggleConfig() => new MdlWidgetConfig<MaterialIconToggle>(
    "mdl-js-icon-toggle", (final html.HtmlElement element) => new MaterialIconToggle.fromElement(element));

/// registration-Helper
void registerMaterialIconToggle() => componenthandler.register(materialIconToggleConfig());

/**
 * Sample:
 *       <label class="mdl-icon-toggle mdl-js-icon-toggle mdl-js-ripple-effect" for="checkbox-1">
 *           <input type="checkbox" id="checkbox-1" class="mdl-icon-toggle__input" />
 *           <span class="mdl-icon-toggle__label mdl-icon mdl-icon--format-bold"></span>
 *       </label>
 */
class MaterialIconToggle extends MdlComponent {
    final Logger _logger = new Logger('mdlcomponents.MaterialIconToggle');

    static const _MaterialIconToggleConstant _constant = const _MaterialIconToggleConstant();
    static const _MaterialIconToggleCssClasses _cssClasses = const _MaterialIconToggleCssClasses();

    html.InputElement _inputElement = null;

    MaterialIconToggle.fromElement(final html.HtmlElement element) : super(element) {
        _init();
    }

    static MaterialIconToggle widget(final html.HtmlElement element) => mdlComponent(element) as MaterialIconToggle;

    // Central Element - by default this is where mdl-icon-toggle was found (element)
    html.Element get hub => inputElement;

    html.InputElement get inputElement {
        if(_inputElement == null) {
            _inputElement = element.querySelector('.${_cssClasses.INPUT}');
        }
        return _inputElement;
    }


    /// Disable icon toggle
    void disable() {

        inputElement.disabled = true;
        _updateClasses();
    }

    /// Enable icon toggle.
    void enable() {

        inputElement.disabled = false;
        _updateClasses();
    }

    /// Check icon toggle.
    void check() {

        inputElement.checked = true;
        _updateClasses();
    }

    /// Uncheck icon toggle.
    void uncheck() {

        inputElement.checked = false;
        _updateClasses();
    }

    void set checked(final bool _checked) => _checked ? check() : uncheck();
    bool get checked => inputElement.checked;

    void set disabled(final bool _disabled) => _disabled ? disable() : enable();
    bool get disabled => inputElement.disabled;

    //- private -----------------------------------------------------------------------------------

    void _init() {
        _logger.fine("MaterialIconToggle - init");

        if (element != null) {

            if (element.classes.contains(_cssClasses.JS_RIPPLE_EFFECT)) {
                element.classes.add(_cssClasses.RIPPLE_IGNORE_EVENTS);

                final html.SpanElement rippleContainer = new html.SpanElement();
                rippleContainer.classes.add(_cssClasses.RIPPLE_CONTAINER);
                rippleContainer.classes.add(_cssClasses.JS_RIPPLE_EFFECT);
                rippleContainer.classes.add(_cssClasses.RIPPLE_CENTER);

                rippleContainer.onMouseUp.listen(_onMouseUp);

                final ripple = new html.SpanElement();
                ripple.classes.add(_cssClasses.RIPPLE);

                rippleContainer.append(ripple);
                element.append(rippleContainer);
            }

            inputElement.onChange.listen(_onChange);

            inputElement.onFocus.listen( _onFocus);

            inputElement.onBlur.listen( _onBlur);

            element.onMouseUp.listen(_onMouseUp);

            _updateClasses();
            element.classes.add(_cssClasses.IS_UPGRADED);
        }
    }

    /// Handle change of state.
    void _onChange(_) {
        _updateClasses();
    }

    /// Handle focus of element.
    void _onFocus(final html.Event event) {

        element.classes.add(_cssClasses.IS_FOCUSED);
    }

    /// Handle lost focus of element.
    void _onBlur(final html.Event event) {

        element.classes.remove(_cssClasses.IS_FOCUSED);
    }

    /// Handle mouseup.
    void _onMouseUp(final html.MouseEvent event) {
        _blur();
    }

    /// Handle class updates.
    /// The [button] whose classes we should update.
    /// The [label] whose classes we should update.
    void _updateClasses() {

        if (inputElement.disabled) {
            element.classes.add(_cssClasses.IS_DISABLED);

        } else {
            element.classes.remove(_cssClasses.IS_DISABLED);
        }

        if (inputElement.checked) {
            element.classes.add(_cssClasses.IS_CHECKED);

        } else {
            element.classes.remove(_cssClasses.IS_CHECKED);
        }
    }

    /// Add blur.
    void _blur() {

        // TODO: figure out why there's a focus event being fired after our blur,
        // so that we can avoid this hack.
        new Timer(new Duration(milliseconds : _constant.TINY_TIMEOUT_IN_MS ), () {
            inputElement.blur();
        });
    }
}

