#include QMK_KEYBOARD_H

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

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

	[TYP] = LAYOUT_preonic_grid(
  //┌────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┐
     KC_TILD, KC_EXLM,  KC_AT,  KC_HASH,  KC_DLR, KC_PERC, KC_CIRC, KC_AMPR, KC_ASTR, KC_PIPE, KC_EQL,  KC_BSLS,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
     KC_LALT, KC_QUOT, KC_COMM,  KC_DOT,   KC_P,    KC_Y,    KC_F,    KC_G,    KC_C,    KC_R,    KC_L,  KC_LALT,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
     KC_TAB,    KC_A,    KC_O,    KC_E,    KC_U,    KC_I,    KC_D,    KC_H,    KC_T,    KC_N,    KC_S,  KC_MINS,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
     KC_WBAK, KC_COLN,   KC_Q,    KC_J,    KC_K,    KC_X,    KC_B,    KC_M,    KC_W,    KC_V,    KC_Z,  KC_WFWD,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
 KC_LCTL, KC_LALT, KC_LGUI, MO(LMOD), LT(NUM,KC_ESC), LT(SFT,KC_BSPC), LT(SYM,KC_SPC), LT(NAV,KC_ENT), MO(RMOD), KC_NO, KC_LALT, KC_LGUI),
  //└────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┘

	[SYM] = LAYOUT_preonic_grid(
  //┌────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┐
      KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
     KC_NO, KC_TRNS, KC_COMM, KC_DOT, KC_SCLN, KC_PERC, LSFT(KC_QUOT), KC_EQL, KC_UNDS, KC_PLUS, KC_ASTR, KC_TRNS,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
     KC_TRNS,  KC_LT,  KC_LCBR, KC_LBRC, KC_LPRN, KC_BSLS, KC_SLSH, KC_RPRN, KC_RBRC, KC_RCBR,  KC_GT,  KC_MINS,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
     KC_TRNS,  KC_AT,  KC_DLR,  KC_AMPR, KC_EXLM, KC_GRV,  KC_TILD, KC_QUES, KC_PIPE, KC_HASH, KC_CIRC, KC_TRNS,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
     KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,  MO(FNUM),  KC_TRNS, KC_ENT,   KC_NO,   KC_NO,  KC_TRNS, KC_TRNS),
  //└────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┘

	[NUM] = LAYOUT_preonic_grid(
  //┌────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┐
      KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,  KC_PEQL, KC_PSLS, KC_PAST, KC_PMNS,  KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
   KC_TRNS, LCA(KC_LSFT), LCTL(KC_LSFT), LALT(KC_LSFT), LGUI(KC_LSFT), KC_NO, KC_NO, KC_7, KC_8, KC_9, KC_PPLS, KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
     KC_TRNS, KC_LSFT, KC_LCTL, KC_LALT, KC_LGUI,  KC_NO,  KC_BSPC,   KC_4,    KC_5,    KC_6,  KC_COMM, KC_PENT,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
   KC_NO, SGUI(KC_LALT), LCTL(KC_LALT), MEH(KC_LGUI), LGUI(KC_LALT), KC_NO, KC_NO, KC_1, KC_2, KC_3, KC_NO, KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
      KC_NO,   KC_NO,   KC_NO,   KC_NO,  KC_TRNS, KC_TRNS,  KC_SPC,   KC_0,  KC_PDOT,   KC_NO,   KC_NO,   KC_NO),
  //└────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┘

	[NAV] = LAYOUT_preonic_grid(
  //┌────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┐
      KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
 KC_TRNS, LCA(KC_LSFT), LCTL(KC_LSFT), LALT(KC_LSFT), LGUI(KC_LSFT), KC_NO, KC_NO, KC_PGUP, KC_UP, KC_PGDN, KC_NO, KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
     KC_TRNS, KC_LSFT, KC_LCTL, KC_LALT, KC_LGUI,  KC_NO,  KC_HOME, KC_LEFT, KC_DOWN, KC_RGHT, KC_END,   KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
 KC_NO, SGUI(KC_LALT), LCTL(KC_LALT), MEH(KC_LGUI), LGUI(KC_LALT), KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
      KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_DEL, KC_TRNS, KC_TRNS, KC_TRNS,  KC_NO,   KC_NO,   KC_NO,   KC_NO),
  //└────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┘

	[FNUM] = LAYOUT_preonic_grid(
  //┌────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┐
      KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_F10,  KC_F11,  KC_F12,  KC_NO,   KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
   KC_TRNS, LCA(KC_LSFT), LCTL(KC_LSFT), LALT(KC_LSFT), LGUI(KC_LSFT), KC_NO, KC_NO, KC_F7, KC_F8, KC_F9, KC__VOLUP, KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
      KC_TRNS, KC_LSFT, KC_LCTL, KC_LALT, KC_LGUI,  KC_NO,   KC_NO,   KC_F4,   KC_F5,   KC_F6, KC__MUTE, KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
  KC_NO, SGUI(KC_LALT), LCTL(KC_LALT), MEH(KC_LGUI), LGUI(KC_LALT), KC_NO, KC_NO, KC_F1, KC_F2, KC_F3, KC__VOLDOWN, KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
      KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,  KC_TRNS, KC_TRNS, KC_TRNS,  KC_NO,   KC_NO,   KC_NO,   KC_NO),
  //└────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┘

	[SFT] = LAYOUT_preonic_grid(
  //┌────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┐
      KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
LSFT(KC_LALT), LSFT(KC_QUOT), KC_TRNS, KC_TRNS, LSFT(KC_P), LSFT(KC_Y), LSFT(KC_F), LSFT(KC_G), LSFT(KC_C), LSFT(KC_R), LSFT(KC_L), LSFT(KC_LALT),
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
LSFT(KC_TAB), LSFT(KC_A), LSFT(KC_O), LSFT(KC_E), LSFT(KC_U), LSFT(KC_I), LSFT(KC_D), LSFT(KC_H), LSFT(KC_T), LSFT(KC_N), LSFT(KC_S), KC_TRNS,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
KC_TRNS, KC_TRNS, LSFT(KC_Q), LSFT(KC_J), LSFT(KC_K), LSFT(KC_X), LSFT(KC_B), LSFT(KC_M), LSFT(KC_W), LSFT(KC_V), LSFT(KC_Z), KC_TRNS,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
LSFT(KC_LCTL), LSFT(KC_LALT), KC_NO, KC_NO, KC_TRNS, LSFT(KC_BSPC), LSFT(KC_SPC), LSFT(KC_ENT), KC_NO, KC_NO, LSFT(KC_LALT), LSFT(KC_LGUI)),
  //└────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┘

	[LMOD] = LAYOUT_preonic_grid(
  //┌────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┐
      KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
KC_NO, LCA(KC_LSFT), LCTL(KC_LSFT), LALT(KC_LSFT), LGUI(KC_LSFT), KC_NO, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
      KC_NO,  KC_LSFT, KC_LCTL, KC_LALT, KC_RGUI,  KC_NO,  KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
KC_NO, SGUI(KC_LALT), LCTL(KC_LALT), MEH(KC_LGUI), LGUI(KC_LALT), KC_NO, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
      KC_NO,   KC_NO,   KC_NO,  KC_TRNS,  KC_NO,   KC_NO,  KC_TRNS, KC_TRNS,  KC_NO,   KC_NO,   KC_NO,   KC_NO),
  //└────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┘

	[RMOD] = LAYOUT_preonic_grid(
  //┌────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┐
      KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_NO, LGUI(KC_LSFT), LALT(KC_LSFT), LCTL(KC_LSFT), LCA(KC_LSFT), KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
     KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,  KC_NO,  KC_LGUI, KC_LALT, KC_LCTL, KC_LSFT,  KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_NO, LGUI(KC_LALT), MEH(KC_LGUI), LCTL(KC_LALT), SGUI(KC_LALT), KC_NO,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
      KC_NO,   KC_NO,   KC_NO,   MO(SYM),  KC_TRNS, KC_TRNS,  KC_NO,   KC_NO,  KC_TRNS,  KC_NO,   KC_NO,   KC_NO)
  //└────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┘

};
