From: David Miller <davem@davemloft.net>
Date: Wed, 22 Jun 2016 18:48:01 +0000
Subject: Re: [PATCH] sparc64: Swap registers for fault code and address in mna trap
Message-Id: <20160622.144801.1635213470824395549.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <TYXPR01MB0589F696D4EADB7B1244D97A99570@TYXPR01MB0589.jpnprd01.prod.outlook.com>
	<20160617.231234.1295900275353757289.davem@davemloft.net>
	<TYXPR01MB05893FD71E27BA04B44B5625992B0@TYXPR01MB0589.jpnprd01.prod.outlook.com>
In-Reply-To: <TYXPR01MB05893FD71E27BA04B44B5625992B0@TYXPR01MB0589.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
To: hikanda@zlab.co.jp
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: 神田　尚 <hikanda@zlab.co.jp>
Date: Tue, 21 Jun 2016 10:36:42 +0000

> Hi, David
> 
> Thank you for your reply.
> 
>> If you can really trigger this code path, please post the kernel log
>> backtrace that happens when the BUG() triggers.  That way we can
>> figure out what the real problem is.
> I'm sorry I cannot show the information. I don't have now.
> In fact, BUG() in do_sparc64_fault occurred in modified version
> of linux-2.6.25.8 on SPARC64VIIIfx. I'm misunderstanding that
> the same problem remains in the latest.

You have to show me that the calltrace occurs with the latest
kernel.
