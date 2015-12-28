(function($) {
    $.fn.bootstrapValidator.i18n.test = $.extend($.fn.bootstrapValidator.i18n.test || {}, {
        'default': 'Please enter a test value'
    });

    $.fn.bootstrapValidator.validators.test = {
        html5Attributes: {
            message: 'message',
            field: 'field'
        },

        /**
         * Return true if the input value is test with given field's value
         *
         * @param {BootstrapValidator} validator The validator plugin instance
         * @param {jQuery} $field Field element
         * @param {Object} options Consists of the following key:
         * - field: The name of field that will be used to compare with current one
         * - message: The invalid message
         * @returns {Boolean}
         */
        validate: function(validator, $field, options) {
            var value = $field.val();
            if (value === '') {
                return true;
            }

            var fields  = options.field.split(','),
                isValid = true;

            for (var i = 0; i < fields.length; i++) {
                var compareWith = validator.getFieldElements(fields[i]);
                if (compareWith == null || compareWith.length === 0) {
                    continue;
                }

                var compareValue = compareWith.val();
                if (value === compareValue) {
                    isValid = false;
                } else if (compareValue !== '') {
                    validator.updateStatus(compareWith, validator.STATUS_VALID, 'test');
                }
            }

            return isValid;
        }
    };
}(window.jQuery));
