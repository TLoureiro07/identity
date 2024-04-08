



window.addEventListener("message", function (event) {
	var item = event.data;
	switch (item.type) {
		case "enableui":
			app.ToggleUI(item.enable)
			app.SetMaximumValues(item.maxValues)
			app.SetLogo(item.Logo)
			app.SetTranslation(item.Translation)
			break;
		case "set_translation":
			app.SetTranslation(item.Translation)
			break
		case "CHECK_NUI_READY":
			$.post('https://esx_identity/nuiReady', JSON.stringify({

			}));
			break
		case "openidentity":
			const identityType = item.identityType
			const data = item.data
			app.ShowIdCard(identityType, data)
			break
		case "hide":
			app.HideIdentity()
			break
		case "setdiscord":
			app.SetDiscordImage(item.image)
			break
		default:

			break;
	}
});

window.addEventListener('load', (event) => {
});


$(document).ready(function () {
	$.post('http://esx_identity/ready', JSON.stringify({}));
})
const app = new Vue({
	el: "#app",

	data: {
		showui: false,
		page: 'main',
		logo: 'https://i.imgur.com/r4fweeQ.png',
		heightSize: 120,
		Translation: {},
		achievementsSwiper: false,
		selectedGender: 'm',
		firstname: '',
		lastname: '',
		dob: '',
		dobClass: 'error',
		firstnameClass: 'error',
		lastnameClass: 'error',
		highestYear: 2003,
		lowestYear: 1900,
		maxHeight: 200,
		minHeight: 120,
		MaxNameLength: 12,
		showPDIdentity: false,
		showEMSIdentity: false,
		showCIVILIANIdentity: false,
		showDMV: false,
		idCardData: {},
		timeoutData: {},
		discordImage: '',

	},
	computed: {
		GetFirstname() {
			if (this.firstname.length > 0 && this.firstname.length < 13) {
				return this.firstname
			} else {
				return 'Loureiro'
			}
		},
		GetDob() {
			if (this.dob.length > 0) {
				return this.dob
			} else {
				return '1968-07-09'
			}
		},
		GetLastname() {
			if (this.lastname && this.lastname.length > 0 && this.firstname.length < 13) {
				return this.lastname
			} else {
				return 'Neves'
			}
		},
		/*GetHeightInputStyle() {
			return {
				background:
					"linear-gradient(to right, rgba(255, 255, 255, 1) 0%, rgba(255, 255, 255, 1) " +
					this.GetValue(this.heightSize, this.maxHeight, this.minHeight) +
					"%,rgba(255, 255, 255, 0.12) " +
					this.GetValue(this.heightSize, this.maxHeight, this.minHeight) +
					"%, rgba(255, 255, 255, 0.12) 100%)",
			}
		},*/
	},
	methods: {
		SetTranslation(translation) {
			this.Translation = translation
		},
		SetLogo(logo) {
			this.logo = logo
		},
		SetDiscordImage(val) {
			this.discordImage = val
		},
		HideIdentity() {
			if (this.timeoutData['pd']) {
				clearTimeout(this.timeoutData['pd'])
				this.timeoutData['pd'] = false
			}

			if (this.timeoutData['ems']) {
				clearTimeout(this.timeoutData['ems'])
				this.timeoutData['ems'] = false
			}

			if (this.timeoutData['civilian']) {
				clearTimeout(this.timeoutData['civilian'])
				this.timeoutData['civilian'] = false
			}

			if (this.timeoutData['driver_license']) {
				clearTimeout(this.timeoutData['driver_license'])
				this.timeoutData['driver_license'] = false
			}

			this.showCIVILIANIdentity = false
			this.showEMSIdentity = false
			this.showPDIdentity = false
			this.showDMV = false

		},
		ShowIdCard(type, data) {
			this.idCardData[type] = data
			if (this.timeoutData[type]) {
				clearTimeout(this.timeoutData[type])
				this.timeoutData[type] = false
			}
			if (type == 'pd') {
				this.showPDIdentity = true
				this.timeoutData[type] = setTimeout(() => {
					this.showPDIdentity = false
					this.timeoutData[type] = false
				}, 9000)
			}
			if (type == 'ems') {
				this.showEMSIdentity = true
				this.timeoutData[type] = setTimeout(() => {
					this.showEMSIdentity = false
					this.timeoutData[type] = false
				}, 9000)
			}
			if (type == 'civilian') {
				this.showCIVILIANIdentity = true
				this.timeoutData[type] = setTimeout(() => {
					this.showCIVILIANIdentity = false
					this.timeoutData[type] = false
				}, 9000)
			}

			if (type == 'driver_license') {
				this.showDMV = true
				this.timeoutData[type] = setTimeout(() => {
					this.showDMV = false
					this.timeoutData[type] = false
				}, 9000)
			}
		},
		SetMaximumValues(data) {
			this.highestYear = data.HighestYear
			this.lowestYear = data.LowestYear
			this.maxHeight = data.MaxHeight
			this.minHeight = data.MinHeight
			this.MaxNameLength = data.MaxNameLength
		},
		checkDOB() {
			var date = new Date(this.dob);
			day = date.getDate();
			month = date.getMonth() + 1;
			year = date.getFullYear();
			if (isNaN(month) || isNaN(day) || isNaN(year)) {
				this.dobClass = 'error'
			}
			else {
				var dateInput = [day, month, year].join('/');

				var regExp = /^(\d{1,2})(\/|-)(\d{1,2})(\/|-)(\d{4})$/;
				var dateArray = dateInput.match(regExp);

				if (dateArray == null) {
					return false;
				}

				month = dateArray[1];
				day = dateArray[3];
				year = dateArray[5];

				if (year > this.highestYear || year < this.lowestYear) {
					this.dobClass = 'error'
					return
				}
				this.dobClass = 'success'

			}
		},
		Register() {
			// Verify date
			var date = this.dob
			var dateCheck = new Date(this.dob);

			if (dateCheck == "Invalid Date") {
				date == "invalid";
			}
			else {
				const ye = new Intl.DateTimeFormat('en', { year: 'numeric' }).format(dateCheck)
				const mo = new Intl.DateTimeFormat('en', { month: '2-digit' }).format(dateCheck)
				const da = new Intl.DateTimeFormat('en', { day: '2-digit' }).format(dateCheck)

				var formattedDate = `${mo}/${da}/${ye}`;
				if (ye > this.highestYear || ye < this.lowestYear) {
					return
				}
				if (!this.checkFirstName() || !this.checkLastname()) {
					return
				}
				$.post('https://esx_identity/register', JSON.stringify({
					firstname: this.firstname,
					lastname: this.lastname,
					dateofbirth: formattedDate,
					sex: this.selectedGender,
					height: this.heightSize
				}));
				this.firstname = ''
				this.lastname = ''
				this.dob = ''
				this.selectedGender = 'm'
				this.heightSize = 120


			}
		},
		SetGender(val) {
			this.selectedGender = val
			$.post('https://esx_identity/GenderChange', JSON.stringify({
				sex: this.selectedGender,
			}));
		},
		ToggleUI(val) {
			this.showui = val
			if (this.showui) {
				this.setupAchievementsSwiper();

			}
		},
		GetValue(val, max, min) {
			var d = (val - min) / (max - min);
			var percent = d * 100;
			return percent;
		},
		isNumber(e) {
			var key = e.which || e.KeyCode;
			if (key >= 48 && key <= 57) {
				return true;
			}
			else {
				return false;
			}
		},
		
		checkFirstName() {
			var value = this.firstname;
			if (value.trim().match(/^[a-zA-Z][0-9a-zA-Z .,'-]*$/) == null) {
				this.firstnameClass = 'error'
				return false

			}
			else {
				if (value.length > 0 && value.length < this.MaxNameLength) {
					this.firstnameClass = 'success'
					return true

				}
				else {
					this.firstnameClass = 'error'
					return false

				}
			}
		},
		checkLastname() {
			var value = this.lastname;
			if (value.trim().match(/^[a-zA-Z][0-9a-zA-Z .,'-]*$/) == null) {
				this.lastnameClass = 'error'
				return false

			}
			else {
				if (value.length > 0 && value.length < this.MaxNameLength) {
					this.lastnameClass = 'success'
					return true

				}
				else {
					this.lastnameClass = 'error'
					return false
				}
			}
		},
		setupAchievementsSwiper() {
			if (this.achievementsSwiper) {
				this.achievementsSwiper.destroy()
				this.achievementsSwiper = false
			}
			Vue.nextTick(() => {
				this.achievementsSwiper = new Swiper('.mySwiper', {
					direction: 'horizontal',
					rewind: true,
					cssMode: true,

					slidesPerView: 1,
					slidesPerGroup: 1,

					navigation: {
						nextEl: '.swiper-button-next',
						prevEl: '.swiper-button-prev',
					},
					pagination: {
						el: ".swiper-pagination",
						type: 'bullets',
					},


				});


			})

		},




	},




})


