From: "Julian Calaby" <julian.calaby@gmail.com>
Date: Tue, 09 Dec 2008 03:15:47 +0000
Subject: Re: [PATCH] sparc: unify kernel/cpu
Message-Id: <646765f40812081915i60f789dcw25c0b5f4a6aedd2c@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20081206210237.GA27594@uranus.ravnborg.org>
In-Reply-To: <20081206210237.GA27594@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Dec 7, 2008 at 08:02, Sam Ravnborg <sam@ravnborg.org> wrote:
> o use cpu_32.c as base
> o move all sparc64 definitions to the common cpu.c
> o use ifdef for the parts that differs and use cpu_32 as base
> o spitfire.h required a CONFIG_SPARC64 guard to fix build on 32 bit
>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>
> This is build tested only!
> I need to get a sparc system soon if I shall continue this...

If you want a sparc64 machine, I have a spare Ultra1e with a 2 GB disk
that I'm willing to mail you if you live in Australia or are willing
to pay the postage.

Thanks,

-- 

Julian Calaby

Email: julian.calaby@gmail.com
