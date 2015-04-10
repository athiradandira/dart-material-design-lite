part of mdlcomponents;

/// Store strings for class names defined by this component that are used in
/// Dart. This allows us to simply change it in one place should we
/// decide to modify at a later date.
class _MaterialTabsCssClasses {
    final String TAB_CLASS = 'mdl-tabs__tab';
    final String PANEL_CLASS = 'mdl-tabs__panel';
    final String ACTIVE_CLASS = 'is-active';
    final String UPGRADED_CLASS = 'is-upgraded';

    final String MDL_JS_RIPPLE_EFFECT = 'mdl-js-ripple-effect';
    final String MDL_RIPPLE_CONTAINER = 'mdl-tabs__ripple-container';
    final String MDL_RIPPLE = 'mdl-ripple';
    final String MDL_JS_RIPPLE_EFFECT_IGNORE_EVENTS = 'mdl-js-ripple-effect--ignore-events';
    const _MaterialTabsCssClasses();
}

/// Store constants in one place so they can be updated easily.
class _MaterialTabsConstant {
    const _MaterialTabsConstant();
}

/// creates MdlConfig for MaterialTabs
MdlConfig materialTabsConfig() => new MdlWidgetConfig<MaterialTabs>(
    "mdl-js-tabs", (final html.HtmlElement element) => new MaterialTabs.fromElement(element));

/// registration-Helper
void registerMaterialTabs() => componenthandler.register(materialTabsConfig());

class MaterialTabs extends MdlComponent {
    final Logger _logger = new Logger('mdlcomponents.MaterialTabs');

    static const _MaterialTabsConstant _constant = const _MaterialTabsConstant();
    static const _MaterialTabsCssClasses _cssClasses = const _MaterialTabsCssClasses();

    final List<html.Element> _tabs = new List<html.Element>();
    final List<html.Element> _panels = new List<html.Element>();

    MaterialTabs.fromElement(final html.HtmlElement element) : super(element) {
        _init();
    }

    static MaterialTabs widget(final html.HtmlElement element) => mdlComponent(element) as MaterialTabs;

    //- private -----------------------------------------------------------------------------------

    void _init() {
        _logger.fine("MaterialTabs - init");

        if (element != null) {
            _initTabs();
        }
    }

    /// Handle clicks to a tabs component
    void _initTabs() {

        if (element.classes.contains(_cssClasses.MDL_JS_RIPPLE_EFFECT)) {
            element.classes.add(_cssClasses.MDL_JS_RIPPLE_EFFECT_IGNORE_EVENTS);
        }

        // Select element tabs, document panels
        _tabs.addAll(element.querySelectorAll('.' + _cssClasses.TAB_CLASS));
        _panels.addAll(element.querySelectorAll('.' + _cssClasses.PANEL_CLASS));

        // Create new tabs for each tab element
        for (int i = 0; i < _tabs.length; i++) {
            new MaterialTab(_tabs[i], this);
        }

        element.classes.add(_cssClasses.UPGRADED_CLASS);
    }

    /// Reset tab state, dropping active classes
    void _resetTabState() {

        for (int k = 0; k < _tabs.length; k++) {
            _tabs[k].classes.remove(_cssClasses.ACTIVE_CLASS);
        }
    }

    /// Reset panel state, droping active classes
    void _resetPanelState() {

        for (int j = 0; j < _panels.length; j++) {
            _panels[j].classes.remove(_cssClasses.ACTIVE_CLASS);
        }
    }
}

class MaterialTab {
    final html.Element tab;
    final MaterialTabs ctx;

    static const _MaterialTabsCssClasses _cssClasses = const _MaterialTabsCssClasses();

    MaterialTab(this.tab,this.ctx) {

        if (tab != null) {
            if (ctx.element.classes.contains(_cssClasses.MDL_JS_RIPPLE_EFFECT)) {

                final html.SpanElement rippleContainer = new html.SpanElement();
                rippleContainer.classes.add(_cssClasses.MDL_RIPPLE_CONTAINER);
                rippleContainer.classes.add(_cssClasses.MDL_JS_RIPPLE_EFFECT);

                final html.SpanElement ripple = new html.SpanElement();
                ripple.classes.add(_cssClasses.MDL_RIPPLE);
                rippleContainer.append(ripple);
                tab.append(rippleContainer);
            }

            tab.onClick.listen( (final html.Event event) {
                event.preventDefault();

                final String attribHref = tab.attributes["href"];
                final String href = attribHref.split('#')[1];
                final html.HtmlElement panel = ctx.element.querySelector('#' + href);

                ctx._resetTabState();
                ctx._resetPanelState();
                tab.classes.add(_cssClasses.ACTIVE_CLASS);
                panel.classes.add(_cssClasses.ACTIVE_CLASS);
            });
        }
    }
}
