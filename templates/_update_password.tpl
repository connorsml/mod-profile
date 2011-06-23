                    <header>
                        <span>{_ Change Your Password _}</span>
                    </header>

                {% wire id="change-password-form" type="submit" postback={updatepassword} 
                                                                   delegate="mod_profile" %}
                <form id="change-password-form" method="post" action="postback">
                   <ol>
                       <li class="textbox">
                           <label for="password_current">{_ Current Password _}</label>
                           <input type="password" name="password_current" id="password_current" />
                           {% validate id="password_current" type={presence} %}
                       </li>

                       <li class="textbox">
                           <label for="password_new">{_ New Password _}</label>
                           <input type="password" name="password_new" id="password_new" />
                           {% validate id="password_new" type={confirmation match="password_confirm"} %}
                       </li>
                       <li class="textbox">
                           <label for="password_confirm">{_ Confirm New Password _}</label>
                           <input type="password" name="password_confirm" id="password_confirm" />
                           {% validate id="password_confirm" type={presence} %}
                       </li>
                       <li>
                           <button type="submit" class="right-button">{_ Save _}</button>
                       </li>
                   </ol>


                </form>