From: David Miller <davem@davemloft.net>
Date: Fri, 26 May 2006 20:15:57 +0000
Subject: Re: 2.6.17-rc3+git seems to corrupt dpkg databases
Message-Id: <20060526.131557.77056605.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0605151108040.27015@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0605151108040.27015@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Smolik <marvin@mydatex.cz>
Date: Fri, 26 May 2006 18:22:15 +0200

> I test it on my E250 with debian sid and 2.6.17-rc4. With 2.6.16.16 no 
> problem with status database. I switch to 2.6.17-rc4 install some 
> package and DB is corrupted. Reboot to 2.6.16.16 and all works. I 
> applied your patch and situation is the same as without patch still db 
> corruption.

Thanks for testing.  Can you double check to make absolutely
sure you had my patch applied?

You seem to have a really good reproducable test case for this,
how do you do it?

Perhaps we can somehow take the state of your package database,
and what it tries to update it to, to make some self-contained
reproducable test case.
