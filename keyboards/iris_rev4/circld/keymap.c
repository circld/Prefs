#include QMK_KEYBOARD_H

// tapdance keycodes
enum td_keycodes {
  ALT_FWD, // `LALT` when held, `LGUI-]` when tapped
  ALT_BWD  // `LALT` when held, `LGUI-[` when tapped
};

// define a type containing as many tapdance states as you need
typedef enum {
  SINGLE_TAP,
  SINGLE_HOLD
} td_state_t;

// create a global instance of the tapdance state type
static td_state_t td_state;

// declare your tapdance functions:

// function to determine the current tapdance state
int cur_dance (qk_tap_dance_state_t *state);

// `finished` and `reset` functions for each tapdance keycode
void altfwd_finished (qk_tap_dance_state_t *state, void *user_data);
void altfwd_reset (qk_tap_dance_state_t *state, void *user_data);
void altbwd_finished (qk_tap_dance_state_t *state, void *user_data);
void altbwd_reset (qk_tap_dance_state_t *state, void *user_data);

// KEYMAP
enum layer_names {
  _TYPING,
  _SYMBOL,
  _NUMERIC,
  _NAVIGATION,
  _FNUM,
  _SHIFT,
  _CTL,
  _GUI,
  _LIGHT
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

	[_TYPING] = LAYOUT(
  //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
      KC_TILD, KC_EXLM, KC_AT,   KC_HASH, KC_DLR,  KC_PERC,                            KC_CIRC, KC_AMPR, KC_ASTR, KC_PIPE, KC_EQL,  KC_BSLS,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
      KC_LSFT, KC_QUOT, KC_COMM, KC_DOT,  KC_P,    KC_Y,                               KC_F,    KC_G,    KC_C,    KC_R,    KC_L,    KC_RSFT,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
      KC_TAB,  KC_A,    KC_O,    KC_E,    KC_U,    KC_I,                               KC_D,    KC_H,    KC_T,    KC_N,    KC_S,    KC_MINS,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
   LGUI(KC_SPC), KC_COLN, KC_Q,  KC_J,    KC_K,    KC_X,    TD(ALT_BWD),         TD(ALT_FWD),  KC_B,    KC_M,    KC_W,    KC_V,    KC_Z,    MO(8),
  //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘        └───┬────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                              LT(6,KC_LCTL), LT(2,KC_ESC), LT(5,KC_BSPC),   LT(1,KC_SPC), LT(3,KC_ENT), LT(7,KC_LGUI)),
                                // └────────┴────────┴────────┘                 └────────┴────────┴────────┘

	[_SYMBOL] = LAYOUT(
  //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
      KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                              KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
      KC_TRNS, KC_TRNS, KC_COMM, KC_DOT,  KC_SCLN, KC_PERC,                            KC_DQUO, KC_EQL, KC_UNDS, KC_PLUS, KC_ASTR, KC_TRNS,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
      KC_TRNS, KC_LT,   KC_LCBR, KC_LBRC, KC_LPRN, KC_BSLS,                            KC_SLSH, KC_RPRN, KC_RBRC, KC_RCBR, KC_GT,   KC_MINS,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
      KC_TRNS, KC_AT,   KC_DLR,  KC_AMPR, KC_EXLM, KC_GRV,  KC_TRNS,         KC_TRNS,  KC_TILD, KC_QUES, KC_PIPE, KC_HASH, KC_CIRC, KC_TRNS,
  //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘        └───┬────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                                     KC_TRNS, KC_TRNS, MO(4),                     KC_TRNS, KC_ENT,  KC_TRNS),
                                // └────────┴────────┴────────┘                 └────────┴────────┴────────┘

	[_NUMERIC] = LAYOUT(
  //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
      KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                              KC_NO,   KC_EQL,  KC_SLSH, KC_ASTR, KC_NO,   KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
  KC_TRNS, LCA(KC_LSFT), LCTL(KC_LSFT), LALT(KC_LSFT), LGUI(KC_LSFT), KC_NO,           KC_NO,   KC_7,    KC_8,    KC_9,    KC_PLUS, KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
      KC_TRNS, KC_LSFT, KC_LCTL, KC_LALT, KC_LGUI, KC_NO,                              KC_NO,   KC_4,    KC_5,    KC_6,    KC_COMM, KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
  KC_NO, SGUI(KC_LALT), LCTL(KC_LALT), MEH(KC_LGUI), LGUI(KC_LALT), KC_NO, KC_NO, KC_BSPC, KC_NO, KC_1,  KC_2,    KC_3,    KC_MINS, KC_NO,
  //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘        └───┬────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                                     KC_NO,   KC_TRNS, KC_TRNS,                   KC_SPC,  KC_0,    KC_DOT),
                                // └────────┴────────┴────────┘                 └────────┴────────┴────────┘

	[_NAVIGATION] = LAYOUT(
  //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
      KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                              KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
  KC_TRNS, LCA(KC_LSFT), LCTL(KC_LSFT), LALT(KC_LSFT), LGUI(KC_LSFT), KC_NO,           KC_NO,   KC_PGUP, KC_UP,   KC_PGDN, KC_NO,   KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
      KC_TRNS, KC_LSFT, KC_LCTL, KC_LALT, KC_LGUI, KC_NO,                              KC_HOME, KC_LEFT, KC_DOWN, KC_RGHT, KC_END,  KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
    KC_NO, SGUI(KC_LALT), LCTL(KC_LALT), MEH(KC_LGUI), LGUI(KC_LALT), KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,   KC_NO,   KC_NO,   KC_NO,
  //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘        └───┬────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                                     KC_NO,   KC_DEL,  KC_TRNS,                   KC_TRNS, KC_TRNS, KC_NO),
                                // └────────┴────────┴────────┘                 └────────┴────────┴────────┘

	[_FNUM] = LAYOUT(
  //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
      KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                              KC_NO,   KC_F10,  KC_F11,  KC_F12,  KC_NO,   KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
    KC_TRNS, LCA(KC_LSFT), LCTL(KC_LSFT), LALT(KC_LSFT), LGUI(KC_LSFT), KC_NO, KC_NO, KC_F7, KC_F8, KC_F9, KC_VOLU, KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
     KC_TRNS, KC_LSFT, KC_LCTL, KC_LALT, KC_LGUI,  KC_NO,                              KC_NO,   KC_F4,   KC_F5,   KC_F6,   KC_MUTE, KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
    KC_NO, SGUI(KC_LALT), LCTL(KC_LALT), MEH(KC_LGUI), LGUI(KC_LALT), KC_NO, KC_NO, KC_NO, KC_NO, KC_F1, KC_F2,   KC_F3,   KC_VOLD, KC_NO,
  //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘        └───┬────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                                     KC_NO,   KC_NO,   KC_TRNS,                   KC_TRNS, KC_BRID, KC_BRIU),
                                // └────────┴────────┴────────┘                 └────────┴────────┴────────┘

	[_SHIFT] = LAYOUT(
  //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
      KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                              KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
  LSFT(KC_LALT), LSFT(KC_QUOT), KC_TRNS, KC_TRNS, LSFT(KC_P), LSFT(KC_Y), LSFT(KC_F), LSFT(KC_G), LSFT(KC_C), LSFT(KC_R), LSFT(KC_L), LSFT(KC_LALT),
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
  LSFT(KC_TAB), LSFT(KC_A), LSFT(KC_O), LSFT(KC_E), LSFT(KC_U), LSFT(KC_I), LSFT(KC_D), LSFT(KC_H), LSFT(KC_T), LSFT(KC_N), LSFT(KC_S), KC_TRNS,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
  KC_TRNS, KC_TRNS, LSFT(KC_Q), LSFT(KC_J), LSFT(KC_K), LSFT(KC_X), KC_TRNS, KC_TRNS, LSFT(KC_B), LSFT(KC_M), LSFT(KC_W), LSFT(KC_V), LSFT(KC_Z), KC_TRNS,
  //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘        └───┬────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                                     KC_TRNS, KC_TRNS, KC_TRNS,           LSFT(KC_SPC), LSFT(KC_ENT), KC_TRNS),
                                // └────────┴────────┴────────┘                 └────────┴────────┴────────┘

	[_CTL] = LAYOUT(
  //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
      KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                              KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
  LCTL(KC_LALT), LCTL(KC_QUOT), KC_TRNS, KC_TRNS, LCTL(KC_P), LCTL(KC_Y), LCTL(KC_F), LCTL(KC_G), LCTL(KC_C), LCTL(KC_R), LCTL(KC_L), LCTL(KC_LALT),
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
  LCTL(KC_TAB), LCTL(KC_A), LCTL(KC_O), LCTL(KC_E), LCTL(KC_U), LCTL(KC_I), LCTL(KC_D), LCTL(KC_H), LCTL(KC_T), LCTL(KC_N), LCTL(KC_S), KC_TRNS,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
  KC_TRNS, KC_TRNS, LCTL(KC_Q), LCTL(KC_J), LCTL(KC_K), LCTL(KC_X), KC_TRNS, LCTL(KC_ENT), LCTL(KC_B), LCTL(KC_M), LCTL(KC_W), LCTL(KC_V), LCTL(KC_Z), KC_TRNS,
  //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘        └───┬────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                                     KC_TRNS, KC_TRNS, KC_TRNS,           LCTL(KC_LSFT), LCTL(KC_LALT), LCTL(KC_LGUI)),
                                // └────────┴────────┴────────┘                 └────────┴────────┴────────┘

	[_GUI] = LAYOUT(
  //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
      KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                              KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
  LGUI(KC_LALT), LGUI(KC_QUOT), KC_TRNS, KC_TRNS, LGUI(KC_P), LGUI(KC_Y), LGUI(KC_F), LGUI(KC_G), LGUI(KC_C), LGUI(KC_R), LGUI(KC_L), LGUI(KC_LALT),
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
  LGUI(KC_TAB), LGUI(KC_A), LGUI(KC_O), LGUI(KC_E), LGUI(KC_U), LGUI(KC_I), LGUI(KC_D), LGUI(KC_H), LGUI(KC_T), LGUI(KC_N), LGUI(KC_S), KC_TRNS,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
  KC_TRNS, KC_TRNS, LGUI(KC_Q), LGUI(KC_J), LGUI(KC_K), LGUI(KC_X), LGUI(KC_ENT), KC_TRNS, LGUI(KC_B), LGUI(KC_M), LGUI(KC_W), LGUI(KC_V), LGUI(KC_Z), KC_TRNS,
  //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘        └───┬────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                             LGUI(KC_LCTL), LGUI(KC_LALT), LGUI(KC_LSFT),        KC_TRNS, KC_TRNS, KC_TRNS),
                                // └────────┴────────┴────────┘                 └────────┴────────┴────────┘

	[_LIGHT] = LAYOUT(
  //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
      KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                              KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
      KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                              KC_NO,   RGB_HUI, RGB_SAI, RGB_VAI, KC_NO,   KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
      KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                              RGB_TOG, RGB_HUD, RGB_SAD, RGB_VAD, KC_NO,   KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
      KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,            RGB_MOD, KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_TRNS,
  //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘        └───┬────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                                     KC_NO,   KC_NO,   KC_NO,                    RGB_RMOD, KC_NO,   KC_NO)
                                // └────────┴────────┴────────┘                 └────────┴────────┴────────┘
};

// determine the tapdance state to return
int cur_dance (qk_tap_dance_state_t *state) {
  if (state->count == 1) {
    if (state->interrupted || !state->pressed) { return SINGLE_TAP; }
    else { return SINGLE_HOLD; }
  }
  else { return 2; } // any number higher than the maximum state value you return above
}

// handle the possible states for each tapdance keycode you define:

void altfwd_finished (qk_tap_dance_state_t *state, void *user_data) {
  td_state = cur_dance(state);
  switch (td_state) {
    case SINGLE_TAP:
      register_mods(MOD_BIT(KC_LGUI));
      register_code16(KC_RBRC);
      break;
    case SINGLE_HOLD:
      register_mods(MOD_BIT(KC_LALT));
  }
}

void altfwd_reset (qk_tap_dance_state_t *state, void *user_data) {
  switch (td_state) {
    case SINGLE_TAP:
      unregister_code16(KC_RBRC);
      unregister_mods(MOD_BIT(KC_LGUI));
      break;
    case SINGLE_HOLD:
      unregister_mods(MOD_BIT(KC_LALT));
  }
}

void altbwd_finished (qk_tap_dance_state_t *state, void *user_data) {
  td_state = cur_dance(state);
  switch (td_state) {
    case SINGLE_TAP:
      register_mods(MOD_BIT(KC_LGUI));
      register_code16(KC_LBRC);
      break;
    case SINGLE_HOLD:
      register_mods(MOD_BIT(KC_LALT));
  }
}

void altbwd_reset (qk_tap_dance_state_t *state, void *user_data) {
  switch (td_state) {
    case SINGLE_TAP:
      unregister_code16(KC_LBRC);
      unregister_mods(MOD_BIT(KC_LGUI));
      break;
    case SINGLE_HOLD:
      unregister_mods(MOD_BIT(KC_LALT));
  }
}

// define `ACTION_TAP_DANCE_FN_ADVANCED()` for each tapdance keycode, passing in `finished` and `reset` functions
qk_tap_dance_action_t tap_dance_actions[] = {
  [ALT_FWD] = ACTION_TAP_DANCE_FN_ADVANCED(NULL, altfwd_finished, altfwd_reset),
  [ALT_BWD] = ACTION_TAP_DANCE_FN_ADVANCED(NULL, altbwd_finished, altbwd_reset)
};
