{% extends "base.tpl" %}

{% block title %}{_ Manage your profile _}{% endblock %}

{% block content %}
    {% with m.acl.user as user_id %}
        {% if user_id  %}
            {% with m.rsc[user_id] as user %}
                <section id="profile_page">
                    <section id="profil-personnal-informations">
                        <header>
                            <span>{_ Your Details  _}</span>
                        </header>
                        <section id="zavatar" name="zavatar">
                            {% include "_render_avatar.tpl" %}
                        </section>
                        {% include "_upload_avatar.tpl" avatar_container="zavatar" %}
                        <p>Hello <strong>{{user.name_first}}</strong></p>
		    
                    </section>
                    <section id="change-username">
                            <div id="job-status-name" class="job-status"></div>
                            {% include "_update_name.tpl" %}
                    </section>
                    <section id="change-password" class="zp-100 clearfix">
                        <div id="job-status-password" class="job-status"></div>
                        {% include "_update_password.tpl" %}
                    </section>
		    {% all include "_profile_setting_section.tpl" %}    
                </section>

            {% endwith %}
        {% else %}
            <a href="{% url logon back%}">{_ Login _}</a>
        {% endif%}
    {% endwith %}

{% endblock %}
