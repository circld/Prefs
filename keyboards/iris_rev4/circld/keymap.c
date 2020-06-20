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
  TYP,
  SYM,
  NUM,
  NAV,
  FNUM,
  SFT,
  LMOD,
  RMOD,
  LITE
};

// Modifier chords
#define M_SCA LCA(KC_LSFT)
#define M_SC LCTL(KC_LSFT)
#define M_SA LALT(KC_LSFT)
#define M_SG LGUI(KC_LSFT)
#define M_SGA SGUI(KC_LALT)
#define M_CA LCTL(KC_LALT)
#define M_GSCA MEH(KC_LGUI)
#define M_GA LGUI(KC_LALT)

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

	[TYP] = LAYOUT(
  //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
      KC_TILD, KC_EXLM, KC_AT,   KC_HASH, KC_DLR,  KC_PERC,                            KC_CIRC, KC_AMPR, KC_ASTR, KC_PIPE, KC_EQL,  KC_BSLS,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
      KC_LSFT, KC_QUOT, KC_COMM, KC_DOT,  KC_P,    KC_Y,                               KC_F,    KC_G,    KC_C,    KC_R,    KC_L,    KC_RSFT,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
      KC_TAB,  KC_A,    KC_O,    KC_E,    KC_U,    KC_I,                               KC_D,    KC_H,    KC_T,    KC_N,    KC_S,    KC_MINS,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
   LGUI(KC_SPC), KC_COLN, KC_Q,  KC_J,    KC_K,    KC_X,  TD(ALT_BWD),     TD(ALT_FWD),  KC_B,    KC_M,    KC_W,    KC_V,    KC_Z,    MO(8),
  //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘        └───┬────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                                 MO(LMOD), LT(NUM,KC_ESC), LT(SFT,KC_BSPC),  LT(SYM,KC_SPC), LT(NAV,KC_ENT), MO(RMOD)),
                                // └────────┴────────┴────────┘                 └────────┴────────┴────────┘

	[SYM] = LAYOUT(
  //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                            XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
     _______, _______, KC_COMM, KC_DOT,  KC_SCLN, KC_PERC,                            KC_DQUO, KC_EQL, KC_UNDS, KC_PLUS, KC_ASTR, _______,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
     _______,  KC_LT,   KC_LCBR, KC_LBRC, KC_LPRN, KC_BSLS,                            KC_SLSH, KC_RPRN, KC_RBRC, KC_RCBR, KC_GT,   KC_MINS,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
     _______,  KC_AT,   KC_DLR,  KC_AMPR, KC_EXLM, KC_GRV, _______,          _______, KC_TILD, KC_QUES, KC_PIPE, KC_HASH, KC_CIRC, _______,
  //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘        └───┬────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                                    _______, _______, MO(FNUM),                 _______,  KC_ENT, _______),
                                // └────────┴────────┴────────┘                 └────────┴────────┴────────┘

	[NUM] = LAYOUT(
  //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                            XXXXXXX,   KC_EQL,  KC_SLSH, KC_ASTR, XXXXXXX, XXXXXXX,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
     _______,  M_SCA,   M_SC,    M_SA,    M_SG,   XXXXXXX,                            XXXXXXX,   KC_7,    KC_8,    KC_9,  KC_PLUS, XXXXXXX,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
     _______,  KC_LSFT, KC_LCTL, KC_LALT, KC_LGUI, XXXXXXX,                           XXXXXXX,   KC_4,    KC_5,    KC_6,  KC_COMM, XXXXXXX,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
     XXXXXXX,  M_SGA,    M_CA,   M_GSCA,   M_GA,  XXXXXXX, XXXXXXX,          KC_BSPC, XXXXXXX,   KC_1,    KC_2,    KC_3,  KC_MINS, XXXXXXX,
  //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘        └───┬────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                                    XXXXXXX, _______, _______,                    KC_SPC,   KC_0,   KC_DOT),
                                // └────────┴────────┴────────┘                 └────────┴────────┴────────┘

	[NAV] = LAYOUT(
  //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                            XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
     _______,  M_SCA,   M_SC,    M_SA,    M_SG,   XXXXXXX,                            XXXXXXX,  KC_PGUP, KC_UP,  KC_PGDN, XXXXXXX, XXXXXXX,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
     _______, KC_LSFT, KC_LCTL, KC_LALT, KC_LGUI, XXXXXXX,                            KC_HOME, KC_LEFT, KC_DOWN, KC_RGHT,  KC_END, XXXXXXX,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
     XXXXXXX,  M_SGA,    M_CA,   M_GSCA,   M_GA,  XXXXXXX, XXXXXXX,          XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘        └───┬────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                                    XXXXXXX,  KC_DEL,  _______,                 _______, _______, XXXXXXX),
                                // └────────┴────────┴────────┘                 └────────┴────────┴────────┘

	[FNUM] = LAYOUT(
  //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                            XXXXXXX,  KC_F10,  KC_F11,  KC_F12, XXXXXXX, XXXXXXX,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
     _______,  M_SCA,   M_SC,     M_SA,    M_SG,  XXXXXXX,                            XXXXXXX,  KC_F7,   KC_F8,   KC_F9,  KC_VOLU, XXXXXXX,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
     _______, KC_LSFT, KC_LCTL, KC_LALT, KC_LGUI,  XXXXXXX,                           XXXXXXX,  KC_F4,   KC_F5,   KC_F6,  KC_MUTE, XXXXXXX,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
     XXXXXXX,  M_SGA,   M_CA,    M_GSCA,   M_GA,  XXXXXXX, XXXXXXX,          XXXXXXX, XXXXXXX,  KC_F1,   KC_F2,   KC_F3,  KC_VOLD, XXXXXXX,
  //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘        └───┬────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                                    XXXXXXX, XXXXXXX,   _______,                 _______, KC_BRID, KC_BRIU),
                                // └────────┴────────┴────────┘                 └────────┴────────┴────────┘

	[SFT] = LAYOUT(
  //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                            XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
  LSFT(KC_LALT), LSFT(KC_QUOT), _______, _______, LSFT(KC_P), LSFT(KC_Y), LSFT(KC_F), LSFT(KC_G), LSFT(KC_C), LSFT(KC_R), LSFT(KC_L), LSFT(KC_LALT),
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
  LSFT(KC_TAB), LSFT(KC_A), LSFT(KC_O), LSFT(KC_E), LSFT(KC_U), LSFT(KC_I), LSFT(KC_D), LSFT(KC_H), LSFT(KC_T), LSFT(KC_N), LSFT(KC_S), _______,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
  _______, _______, LSFT(KC_Q), LSFT(KC_J), LSFT(KC_K), LSFT(KC_X), _______, _______, LSFT(KC_B), LSFT(KC_M), LSFT(KC_W), LSFT(KC_V), LSFT(KC_Z), _______,
  //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘        └───┬────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                                    _______, _______, _______,             LSFT(KC_SPC), LSFT(KC_ENT), _______),
                                // └────────┴────────┴────────┘                 └────────┴────────┴────────┘

	[LMOD] = LAYOUT(
  //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                            _______, _______, _______, _______, _______, _______,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
     XXXXXXX,  M_SCA,   M_SC,    M_SA,    M_SG,   XXXXXXX,                            _______, _______, _______, _______, _______, _______,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
     XXXXXXX, KC_LSFT, KC_LCTL, KC_LALT, KC_LGUI, XXXXXXX,                            _______, _______, _______, _______, _______, _______,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
     XXXXXXX,  M_SGA,    M_CA,   M_GSCA,   M_GA,  XXXXXXX, XXXXXXX,          _______, _______, _______, _______, _______, _______, _______,
  //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘        └───┬────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                                    _______, _______, _______,                   _______, _______, _______),
                                // └────────┴────────┴────────┘                 └────────┴────────┴────────┘

	[RMOD] = LAYOUT(
  //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
     _______, _______, _______, _______, _______, _______,                            XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
     _______, _______, _______, _______, _______, _______,                            XXXXXXX,   M_SG,    M_SA,    M_SC,   M_SCA,  XXXXXXX,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
     _______, _______, _______, _______, _______, _______,                            XXXXXXX, KC_LGUI, KC_LALT, KC_LCTL, KC_LSFT, XXXXXXX,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
     _______, _______, _______, _______, _______, _______, _______,          XXXXXXX, XXXXXXX,   M_GA,   M_GSCA,   M_CA,   M_SGA,  XXXXXXX,
  //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘        └───┬────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                                    MO(SYM), _______, _______,                   _______, _______, _______),
                                // └────────┴────────┴────────┘                 └────────┴────────┴────────┘

	[LITE] = LAYOUT(
  //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                            XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                            XXXXXXX, RGB_HUI, RGB_SAI, RGB_VAI, XXXXXXX, XXXXXXX,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                            RGB_TOG, RGB_HUD, RGB_SAD, RGB_VAD, XXXXXXX, XXXXXXX,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,          RGB_MOD, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, _______,
  //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘        └───┬────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                                     XXXXXXX, XXXXXXX, XXXXXXX,                    RGB_RMOD, XXXXXXX, XXXXXXX)
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
