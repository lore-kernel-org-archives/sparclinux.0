From: "Julian Calaby" <julian.calaby@gmail.com>
Date: Mon, 05 Jan 2009 22:44:02 +0000
Subject: Re: kill most of sparc_ksyms*
Message-Id: <646765f40901051444v2b9a6eefw227f583336e262d8@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20090105194431.GA4976@uranus.ravnborg.org>
In-Reply-To: <20090105194431.GA4976@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Jan 6, 2009 at 06:44, Sam Ravnborg <sam@ravnborg.org> wrote:
> I gave Julian the receipe but he has focus on the prom_ stuff,
> so I decided to give it a spin.

It's been in the back of my mind, but I've focused on unifying oplib.h
first, then unifying arch/sparc/prom/* then following what you
suggested to *eliminate* sparc_ksyms_*.c

As for going softly softly around the prom_* stuff, don't worry about
it, I've barely started working on that. I'm still cleaning up the
existing code to make it possible to unify it.

If you don't (want to) make a patch to finish this work, I'll handle
it when I get home tonight.

Thanks,

-- 

Julian Calaby

Email: julian.calaby@gmail.com
