export function getUsername_from_email(email){

    const username = email.substring(0, email.indexOf('@'));

    return username;

}