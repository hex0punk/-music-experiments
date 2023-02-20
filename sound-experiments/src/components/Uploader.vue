<template>
    <input v-on:change="handleFileUpload($event)" type="file" name="file" />
    <button @click="upload">Upload</button>
</template>

<script>
export default{
    data() {
        return {
            file: null
        }
    },
    methods: {
        handleFileUpload(event) {
            this.file = event.target.files[0];
        },
        upload() {
            let formData = new FormData();
            formData.append( 'method', 'POST');
            formData.append('file', this.file);
            console.log(formData)
            return fetch('http://localhost:8080/api/file/upload/', {
                method: 'POST',
                body:  formData
            })
            .then((res) => console.log(res.json))
            // .then((json) => (data.value = json))
            .catch((err) => (console.log(err)))
        }
    }
}
</script>