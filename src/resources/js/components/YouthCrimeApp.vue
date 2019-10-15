<template>
	<div id="app">
		<table style="width:75%" class="table table-hover">
            <thead>
                <tr class="table-info">
                    <th scope="col">Date</th>
                    <th scope="col">County</th>
                    <th scope="col">State</th>
                    <th scope="col">Offense</th>
                    <th scope="col">Adjudicated</th>
                    <th scope="col">Sentence</th>
                    <th scope="col">&nbsp</th>
                </tr>
            </thead>

			<youthcrime-component
				v-for="youthcrime in youthcrimes"
				v-bind="youthcrime"
				:key="youthcrime.id"
				@edit="edit"
			></youthcrime-component>

		</table>
	    <div class="form-group">
		    <label for="youth_datefield">Date of Incident:</label>
		    	<input v-model="youth_datefield" style="width:35%;" class="form-control">
		    <label for="countyfield">County:</label>
		    	<input v-model="countyfield" style="width:75%;" class="form-control">
		    <label for="statefield">State:</label>
		    	<input v-model="statefield" style="width:75%;" class="form-control">
		    <label for="offensefield">Offense:</label>
		    	<input v-model="offensefield" style="width:75%;" class="form-control">
		    <p style="width:75%;">Adjudicated:</p>
		    <label for="adjudicatedfield">
            	<input v-model="adjudicatedfield" type="radio" style="margin:5px;" class="radio-inline"  value="Yes" :checked="adjudicatedfield == 'Yes'" />Yes&nbsp;&nbsp;
            </label>
            <label for="adjudicatedfield">
                <input v-model="adjudicatedfield" type="radio" class="radio-inline" style="margin:5px;"  value="No" :checked="adjudicatedfield == 'No'" />No&nbsp;
            </label>
            <br>
		    <label for="sentencefield">Sentence:</label>
		    	<input v-model="sentencefield" style="width:75%;" class="form-control" >		    
		    <button @click="create()" style="margin-top:10px;" class="btn btn-info">Save</button>
		</div>
	</div>

</template>

<script>
	function YouthCrime({id, youth_date, county, state, offense, adjudicated, sentence}) {
		this.id = id;
		this.youth_date = youth_date;
		this.county = county;
		this.state = state;
		this.offense = offense;
		this.adjudicated = adjudicated;
		this.sentence = sentence;
	}

	import youthcrimeComponent from './YouthCrimeComponent.vue';

	export default {
		data() {
				return {
					youthcrimes: [],
					app_id: $("#appid").attr("appid"), //from appid in blade 					
					youth_datefield: '',
					countyfield: '',
					statefield: '',
					offensefield: '',
					adjudicatedfield: '',
					sentencefield: '',
					working:false
				}
				
		},
		methods: {
			create() {
		        axios.post('/api/youthcrimes/store', ({
		        	app_id: this.app_id, 
		        	youth_date: this.youth_datefield,
		        	county: this.countyfield,
		        	state: this.statefield,
		        	offense: this.offensefield,
		        	adjudicated: this.adjudicatedfield,
		        	sentence: this.sentencefield
		        	 }))
		        .then(({ data }) => {
		          this.youthcrimes.push({ data });
		        })
		        .catch((error) => {
			        if (error.response) {
			            console.log(error.response.data);
			            console.log(error.response.status);
			            console.log(error.response.headers);
			        } else if (error.request) {
			            console.log(error.request);
			        } else {
			            console.log('Error', error.message);
			        }
			        console.log(error.config);;
			    });
			},
			read() {
				axios.get('/api/youthcrimes/'+this.app_id).then(({ data }) => {
					data.forEach(youthcrime => {
						this.youthcrimes.push(new YouthCrime(youthcrime));
					});
				});
			},
			update() {
				//TODO
			},
			edit() {
				//TODO
			},
			del() {
				//TODO
			}
		},
		components: {
				youthcrimeComponent
		},
		created() {
				this.read();
		}

	}
</script>
