From: "Abhishek Sagar" <sagar.abhishek@gmail.com>
Date: Wed, 02 Jul 2008 04:34:59 +0000
Subject: Re: next-0630: sparc64: build failed
Message-Id: <863e9df20807012122u45f7d8dfmc4d11513b19aeadc@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <a4423d670807010825t7ea2eb44oda3f08dc007c40a2@mail.gmail.com>
	 <20080701154648.GA31057@elte.hu> <486A7C19.5080905@gmail.com>
	 <20080701200344.GA4896@elte.hu>
In-Reply-To: <20080701200344.GA4896@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: David Miller <davem@davemloft.net>, Alexander Beregalov <a.beregalov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org, sparclinux@vger.kernel.org, rostedt@goodmis.org

On Wed, Jul 2, 2008 at 1:33 AM, Ingo Molnar <mingo@elte.hu> wrote:
> hm, mcount is the facility - so it makes sense to have that defined.
> Here you basically hide CONFIG_MCOUNT:
>
>> -ifeq ($(CONFIG_MCOUNT),y)
>> -  KBUILD_CFLAGS += -pg
>> +ifneq ($(CONFIG_FTRACE),y)
>> +ifeq ($(CONFIG_STACK_DEBUG),y)
>> +KBUILD_CFLAGS += -pg
>> +endif
>>  endif

Even with CONFIG_MCOUNT we'd have to do something like this to prevent
duplicate -pg flags (I hope there's a prettier way of writing this):

ifneq ($(CONFIG_FTRACE),y)
ifeq ($(CONFIG_MCOUNT),y)
KBUILD_CFLAGS += -pg
endif
endif

> via two conditions. I'm not sure that's a win and i found CONFIG_MCOUNT
> a logical switch - but it's David's call.

Ok, but it really doesn't allow end user to switch between anything
through any menu. It gets selected via:

config MCOUNT
        bool
        depends on STACK_DEBUG || FTRACE
        default y


I was attempting to decouple MCOUNT and STACK_DEBUG, which
incidentally made MCOUNT useless.

--
Regards,
Abhishek Sagar
