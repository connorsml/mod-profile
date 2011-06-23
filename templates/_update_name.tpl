                    <header>
                        <span>{_ Change your name _}</span>
                    </header>

                {% wire id="change-name-form" type="submit" postback={updatename} 
                                                                   delegate="mod_profile" %}

                <form id="change-name-form" method="post" action="postback">
                   <ol>
                       <li class="textbox">
                           <label for="name_first">{_ First Name _}</label>
                           <input type="text" name="name_first" id="name_first" value="{{user.name_first}}" />
                           {% validate id="name_first" type={presence} %}
                       </li>

                       <li class="textbox">
                           <label for="name_surname">{_ Last Name _}</label>
                           <input type="text" name="name_surname" id="name_surname" value="{{user.name_surname}}" />
                           {% validate id="name_surname" type={presence} %}
                       </li>
                       <li>
                           <button type="submit" class="right-button">{_ Save _}</button>
                       </li>
                   </ol>

                </form>