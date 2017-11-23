package org.bluepigeon.admin.exception;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class NameValidator {
	private Pattern pattern;
	private Matcher matcher;

	private static final String NAME_PATTERN =
		"[a-zA-Z]*[ ]{1}";

	public NameValidator() {
		pattern = Pattern.compile(NAME_PATTERN);
	}

	public boolean validate(final String hex) {

		matcher = pattern.matcher(hex);
		return matcher.matches();

	}

}
