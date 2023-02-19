<template>
    <input v-on:change="handleFileUpload($event)" type="file" />
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
            console.log(this.file)
            return fetch('http://localhost:8080/api/file/upload/', {
                method: 'POST',
                headers: {"content-type": "application/json"},
                body:  JSON.stringify({
                    'name': this.file.name,
                    'path': './test/here/',
                    'file': this.file
                })
            })
            .then((res) => console.log(res.json))
            // .then((json) => (data.value = json))
            .catch((err) => (error.value = err))
        }
    }
}
</script>