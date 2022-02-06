<?php

namespace Core\Validation\Rule;


use Illuminate\Contracts\Validation\Rule;

/**
 * Правило для проверки матерных слов
 *
 * Class BannedWordsRule
 * @package Core\Validation\Rule
 */
class BannedWordsRule implements Rule {

	private $censureResult;
	private $bannedWord;

	public function BannedWordsRule() {
		$this->censureResult = false;
		$this->bannedWord = false;
	}

	/**
	 * Проверка на запрещенные слова и мат
	 *
	 * @param  string $attribute аттрибут
	 * @param  mixed $value значения для проверки
	 * @return bool результат проверки
	 */
	public function passes($attribute, $value) {
		$this->censureResult = \Text_Censure::parse($value);
		$this->bannedWord = fox_banned_words_chk($value);
		return $this->censureResult === false
			&& $this->bannedWord === false;
	}

	/**
	 * Сообщение при ошибки валидации
	 *
	 * @return string
	 */
	public function message() {
		return $this->bannedWord ?
			\Translations::t("Вы ввели запрещенное слово: ") . $this->bannedWord :
			\Translations::t("Вы ввели запрещенное слово");
	}
}