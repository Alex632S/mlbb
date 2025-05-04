<template>
  <q-layout class="bg-grey-1 animate__animated animate__fadeInLef">
    <q-header
      elevated
      class="text-white"
      style="background: #19191d"
      height-hint="61.59"
    >
      <q-toolbar class="q-py-md q-px-xl">
        <q-btn
          round
          dense
          flat
          :ripple="false"
          size="19px"
          color="white"
          class="q-mr-sm"
          no-caps
        >
          <img
            class="custom-img"
            src="../assets/logo3.png"
            height="51"
            width="51"
          />
        </q-btn>

        <div
          v-if="$q.screen.gt.sm"
          class="GL__toolbar-link q-ml-xs q-gutter-md text-body2 text-weight-bold row items-center no-wrap animate__animated"
        >
          <a href="javascript:void(0)" class="text-white"> Home </a>
          <a href="javascript:void(0)" class="text-white"> Games </a>
          <a href="javascript:void(0)" class="text-white"> About </a>
        </div>

        <q-space />

        <div class="q-pl-sm q-gutter-sm row items-center no-wrap">
          <q-btn
            v-if="$q.screen.gt.xs"
            dense
            flat
            round
            size="sm"
            icon="notifications"
          />
          <q-btn v-if="$q.screen.gt.xs" dense flat>
            <div class="row items-center no-wrap">
              <q-icon name="add" size="20px" />
              <q-icon
                name="arrow_drop_down"
                size="16px"
                style="margin-left: -2px"
              />
            </div>
            <q-menu auto-close>
              <q-list dense style="min-width: 100px">
                <q-item clickable class="GL__menu-link">
                  <q-item-section>New repository</q-item-section>
                </q-item>
                <q-item clickable class="GL__menu-link">
                  <q-item-section>Import repository</q-item-section>
                </q-item>
                <q-item clickable class="GL__menu-link">
                  <q-item-section>New gist</q-item-section>
                </q-item>
                <q-item clickable class="GL__menu-link">
                  <q-item-section>New organization</q-item-section>
                </q-item>
                <q-separator />
                <q-item-label header>This repository</q-item-label>
                <q-item clickable class="GL__menu-link">
                  <q-item-section>New issue</q-item-section>
                </q-item>
              </q-list>
            </q-menu>
          </q-btn>

          <q-btn dense flat no-wrap>
            <q-avatar rounded size="20px">
              <img src="https://cdn.quasar.dev/img/avatar3.jpg" />
            </q-avatar>
            <q-icon name="arrow_drop_down" size="16px" />

            <q-menu auto-close>
              <q-list dense>
                <q-item class="GL__menu-link-signed-in">
                  <q-item-section>
                    <div>Signed in as <strong>Mary</strong></div>
                  </q-item-section>
                </q-item>
                <q-separator />
                <q-item clickable class="GL__menu-link-status">
                  <q-item-section>
                    <div>
                      <q-icon name="tag_faces" color="blue-9" size="18px" />
                      Set your status
                    </div>
                  </q-item-section>
                </q-item>
                <q-separator />
                <q-item clickable class="GL__menu-link">
                  <q-item-section>Your profile</q-item-section>
                </q-item>
                <q-item clickable class="GL__menu-link">
                  <q-item-section>Your repositories</q-item-section>
                </q-item>
                <q-item clickable class="GL__menu-link">
                  <q-item-section>Your projects</q-item-section>
                </q-item>
                <q-item clickable class="GL__menu-link">
                  <q-item-section>Your stars</q-item-section>
                </q-item>
                <q-item clickable class="GL__menu-link">
                  <q-item-section>Your gists</q-item-section>
                </q-item>
                <q-separator />
                <q-item clickable class="GL__menu-link">
                  <q-item-section>Help</q-item-section>
                </q-item>
                <q-item clickable class="GL__menu-link">
                  <q-item-section>Settings</q-item-section>
                </q-item>
                <q-item clickable class="GL__menu-link">
                  <q-item-section>Sign out</q-item-section>
                </q-item>
              </q-list>
            </q-menu>
          </q-btn>
        </div>
      </q-toolbar>
    </q-header>

    <q-page-container class="overflow-hidden-x">
      <router-view />

      <header
        class="relative-position overflow-hidden-y"
        style="height: 755px; background: rgba(0, 0, 0, 0.7); z-index: 4"
      >
        <div class="custom-content q-px-xl" style="margin-top: 200px">
          <h2>Adopted daughter of House Vance, a clandestine sniper.</h2>
          <span>- Hawk-eyed Sniper.</span>
          <div style="margin-top: 80px">
            <q-btn
              unelevated
              rounded
              color="primary"
              label="Go to Live Event"
              style="padding: 9px 20px"
            />
          </div>
        </div>
        <div class="custom-wrap"></div>
        <div class="absolute" style="width: 100%; z-index: 3">
          <img src="../assets/lesley_hawk.jpg" height="100%" width="100%" />
        </div>
      </header>
      <main class="q-px-xl q-pt-lg">
        <h2 style="color: white">Latest Skins</h2>

        <div class="flex" style="width: 100%; gap: 1rem;">
          <div style="flex: 1 1 65%;" >
            <div class="flex" style="gap: 2rem;">
              <div>
                <img src="../assets/cards/1a.png" height="430" width="302" />
              </div><div>
                <img src="../assets/cards/2a.png" height="430" width="302" />
              </div><div>
                <img src="../assets/cards/3aa.png" height="430" width="302" />
              </div><div>
                <img src="../assets/cards/4a.png" height="430" width="302" />
              </div><div>
                <img src="../assets/cards/5.png" height="430" width="302" />
              </div>
              <div>
                <img src="../assets/cards/6.png" height="430" width="302" />
              </div>
            </div>

            <div class="flex justify-center" style="margin-top: 60px;">
              <p style="color:white; opacity: 25%; max-width: 310px;">There are no more upcoming skins for now. If you would
                like to see calendar of events <a href="#" style="color:white;">click here.</a></p>
            </div>

          </div>

          <div style="flex: 0 1 25%;" class="flex">
            <div>
              <div class="side-menu-custom">
                <h3 style="color: white; margin-top: 0; font-size: 30px;">Categories</h3>
                <div class="custom-raw">

                </div>
                <div class="flex flex-start q-mt-xl" style="gap: 1rem;">
                  <q-btn outline no-caps rounded color="primary"  label="Benedetta" v-for="n in 5" :key="`xl-${n}`"/>
                  <q-btn outline rounded color="red"  label="Live Now" v-for="n in 5" :key="`xl-${n}`"/>
                  <q-btn outline rounded no-caps color="grey"  label="Heroes of the Storm"/>
                  <q-btn outline rounded  color="grey"  label="Vail" v-for="n in 5" :key="`xl-${n}`"/>
                </div>
                <div class="custom-raw q-mt-xl">

                </div>
              </div>
              <div class="q-mt-xl">
                <h3 style="color: white; font-size: 30px;">Upcoming Skins</h3>

                <div style="color: white" v-for="n in 3" :key="`xl-${n}`">
                  <h6 style="margin-bottom: 8px;">Bruno Neymar Jr</h6>
                  <p style="font-size: 16px; margin-bottom: 21px;">in <a href="#" style="color: white">Mobile Legends.</a> <span style="opacity: 25%; font-style: italic">November 23, 2022.</span></p>
                  <div style="width: 100%; height: 2px; background: white; opacity: 25%;"></div>
                </div>
              </div>
            </div>

            <div class="q-mt-xl flex justify-center" style="width: 100%;">
              <q-btn outline rounded color="primary" no-caps size="xl" label="Go to Livestream" style="padding: 9px 22px"/>
            </div>

            <div class="q-mt-lg flex justify-center" style="width: 100%;">
              <span style="color:white; opacity: 25%;">First time? Learn <a href="#" style="color:white;">how to live</a></span>
            </div>

          </div>
        </div>

        <div class="custom-raw q-mt-xl"></div>
      </main>

      <footer class="q-py-xl q-px-xl">
        <div class="flex justify-center align-center">
          <div style="margin-right: 80px">
            <div>
              <img src="../assets/logo302.png" height="114" width="114" />
            </div>
          </div>


          <div class="flex justify-center" style="gap: 60px;">
            <ul class="list-links-custom">
              <li>
                <a href="#">HOME</a>
              </li>
              <li>
                <a href="#">ABOUT</a>
              </li>
              <li>
                <a href="#">FAQ</a>
              </li>
              <li>
                <a href="#">PRESS</a>
              </li>
            </ul>

            <ul class="list-links-custom">
              <li>
                <a href="#">ARTICLES</a>
              </li>
              <li>
                <a href="#">GAMES</a>
              </li>
              <li>
                <a href="#">PRIVACY</a>
              </li>
              <li>
                <a href="#">LEGAL</a>
              </li>
            </ul>

            <ul class="list-links-custom">
              <li>Lyralynx, 2023 21-099, West Java Indonesia</li>
              <li>
                <a href="#">628 315 552 0493</a>
              </li>
              <li>
                <a href="#">feryprst.id@gmail.com</a>
              </li>
            </ul>
          </div>

        </div>

      </footer>
      <div style="width: 100%; background: #19191d" class="q-py-lg q-px-xl text-center">
        <span style="color:white; opacity: 25%;">Copyright © 2023. All rights reserved.</span>
      </div>
    </q-page-container>
  </q-layout>
</template>

<script>
import { ref } from "vue";
import { fabGithub } from "@quasar/extras/fontawesome-v6";

const stringOptions = [
  "quasarframework/quasar",
  "quasarframework/quasar-awesome",
];

export default {
  name: "MyLayout",

  setup() {
    const text = ref("");
    const options = ref(null);
    const filteredOptions = ref([]);
    const search = ref(null); // $refs.search

    function filter(val, update) {
      if (options.value === null) {
        // load data
        setTimeout(() => {
          options.value = stringOptions;
          search.value.filter("");
        }, 2000);
        update();
        return;
      }

      if (val === "") {
        update(() => {
          filteredOptions.value = options.value.map((op) => ({ label: op }));
        });
        return;
      }

      update(() => {
        filteredOptions.value = [
          {
            label: val,
            type: "In this repository",
          },
          {
            label: val,
            type: "All GitHub",
          },
          ...options.value
            .filter((op) => op.toLowerCase().includes(val.toLowerCase()))
            .map((op) => ({ label: op })),
        ];
      });
    }

    return {
      fabGithub,

      text,
      options,
      filteredOptions,
      search,

      filter,
    };
  },
};
</script>

<style lang="sass">
footer
  background: black

.list-links-custom
  li
    list-style: none
    color: white
    margin-bottom: 12px

  a
    text-decoration: none
    color: white


.custom-raw
  width: 100%
  height: 9px
  background: #65D4FC

main
    background: #19191D
.GL

  &__select-GL__menu-link
    .default-type
      visibility: hidden

    &:hover
      background: #0366d6
      color: white
      .q-item__section--side
        color: white
      .default-type
        visibility: visible

  &__toolbar-link
    a
      color: white
      min-width: 78px
      text-decoration: none
      position: relative
      &:hover
        opacity: 0.7

    a::after
      position: absolute
      left: -1px
      bottom: -12px
      content: ''
      width: 115%
      height: 3px
      background-color: white
      border-radius: 3px

      transform: scaleX(0)
      transition: transform 300ms ease-in-out
      transform-origin:  0% 50%

    a:hover:after
      transform: scaleX(1)





  &__menu-link:hover
    background: #0366d6
    color: white

  &__menu-link-signed-in,
  &__menu-link-status
    &:hover
      & > div
        background: white !important

  &__menu-link-status
    color: $blue-grey-6
    &:hover
      color: $light-blue-9

  &__toolbar-select.q-field--focused
    width: 450px !important
    .q-field__append
      display: none



.custom-img
  -webkit-filter: drop-shadow(0px 0px 3px #3a4b4c)
  filter: drop-shadow(0px 0px 3px #3a4b4c)

.custom-wrap
  position: absolute
  z-index: 4
  width: 100%
  height: 755px
  background: rgb(25,25,29)
  background: linear-gradient(0deg, rgba(25,25,29,1) 0%, rgba(19,13,27,1) 10%, rgba(6,11,11,0.5214460784313726) 100%)

.custom-content
  width: 100%
  position: absolute
  z-index: 10
  -webkit-font-smoothing: antialiased
  -moz-osx-font-smoothing: grayscale
  h2
    color: white
    max-width: 800px
    font-size: 50px
  span
    color: white
    font-size: 18px
</style>
