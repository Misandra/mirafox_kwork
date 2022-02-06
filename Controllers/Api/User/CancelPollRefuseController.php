<?php


namespace Controllers\Api\User;


use Controllers\Api\AbstractApiController;
use Symfony\Component\HttpFoundation\Request;
use UserManager;

/**
 * Class CancelPollRefuseController
 * @package Controllers\Api\User
 */
class CancelPollRefuseController extends AbstractApiController {

	/**
	 * @inheritdoc
	 */
	protected function callMethod(Request $request) {
		return UserManager::api_cancelPollRefuse();
	}

	/**
	 * @inheritdoc
	 */
	protected function getMethodName(): string {
		return "User.api_cancelPollRefuse";
	}

	/**
	 * @inheritdoc
	 */
	protected function isParametersNotValid(Request $request): bool {
		return false;
	}
}