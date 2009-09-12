From: David Miller <davem@davemloft.net>
Date: Sat, 12 Sep 2009 09:59:43 +0000
Subject: Re: Sparc release requalification
Message-Id: <20090912.025943.23126173.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Sat, 12 Sep 2009 11:49:54 +0200

> I see this %pcr handling has been in debugging code (oprofile, performance
> counters) for some time before it moved into the NMI handler, so I'm
> guessing it didn't get enough testing because fewer people have the
> debugging features enabled. I would recommend disabling it for now in
> the stable releases until this grave regression is resolved.

Remind me what kernel you're trying now?
