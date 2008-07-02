From: "Alexander Beregalov" <a.beregalov@gmail.com>
Date: Wed, 02 Jul 2008 09:10:02 +0000
Subject: Re: next-0630: sparc64: build failed
Message-Id: <a4423d670807020210i706dcf7du5cfb1e35fadb7cd7@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <a4423d670807010825t7ea2eb44oda3f08dc007c40a2@mail.gmail.com>
	 <20080701154648.GA31057@elte.hu>
In-Reply-To: <20080701154648.GA31057@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, sagar.abhishek@gmail.com, rostedt@goodmis.org

2008/7/1 Ingo Molnar <mingo@elte.hu>:
> thanks Alexander - does the patch below fix it for you?
> commit 760378e1497841246ea7e42abad617d8a8ac0bcc
> Author: Ingo Molnar <mingo@elte.hu>
> Date:   Tue Jul 1 17:35:06 2008 +0200
>
>    fix "ftrace: store mcount address in rec->ip"
>

Yes, it fixes the issue. I have tried next-0702 which already includes
your patch.
But it has a name a1d5d08eb4f5c76acd5bb115e13791ce87ec356b.
