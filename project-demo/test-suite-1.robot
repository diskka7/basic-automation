*** Settings ***
Library           SeleniumLibrary

*** variables ***
${BROWSER}     chrome
${HOST}    http://localhost/wp/login
${EMAIL}    admin
${PASS-1}    admin    # correct password
${PASS-2}    xxs    # wrong password

${COMPANY}    global.inc
${TITLE}    [TEST] Senior Engineering manager
${LOCATION}     Singapore
${TAGS}    engineering manager software
${JOBEMAIL}    jobs@global.co
${WEBSITE}    https://global.co
${DESCRIPTION}     Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 

*** Test Cases ***

# login
# positive test
testcase-1
    Login Success
    Close Browser    

# negative test
testcase-2
    Open Browser    ${HOST}    ${BROWSER}
    input text        name:username       ${EMAIL}
    input text        name:password    ${PASS-2}
    Click Element     xpath://button[@type='submit']
    Page Should Contain Element    xpath=//div[@class='alert bg-danger text-center' and contains(text(), 'Username dan Password salah')]
    Close Browser 

# logout
testcase-3
    Login Success
    Click Element    xpath=//a[@href='http://localhost/wp/login/logout' and i[@class='fa fa-sign-out'] and span[text()='Keluar']]
    Close Browser 

#post job
testcase-4
    Login Success
    Click Element   xpath=//a[@href='http://localhost/wp/hasil' and i[@class='fa fa-graduation-cap'] and span[text()='Hasil']]
    Page Should Contain Element    xpath=//h3[@class='box-title' and contains(text(), 'Hasil Penilaian Seleksi Atlet Bola Tangan')]
    Close Browser 


*** Keywords ***

Scroll Down Until End
    ${previous_height}=    Execute Javascript    return document.body.scrollHeight;
    FOR  ${i}    IN RANGE    10
        Execute Javascript    window.scrollTo(0, document.body.scrollHeight);
        Sleep    1s
        ${current_height}=    Execute Javascript    return document.body.scrollHeight;
        Exit For Loop If    '${current_height}' == '${previous_height}'
        ${previous_height}=    Set Variable    ${current_height}
        Sleep    2s
    END

Login Success
    Open Browser    ${HOST}    ${BROWSER}
    input text        name:username       ${EMAIL}
    input text        name:password    ${PASS-1}
    Click Element     xpath://button[@type='submit']
    Page Should Contain Element    xpath=//h3[@class='box-title' and contains(text(), 'Selamat Datang')]