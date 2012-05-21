From: David Miller <davem@davemloft.net>
Date: Mon, 21 May 2012 21:12:06 +0000
Subject: Re: How to recognize a LEON CPU?
Message-Id: <20120521.171206.1286433189012126202.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120521162253.GB5733@merkur.ravnborg.org>
In-Reply-To: <20120521162253.GB5733@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 May 2012 18:22:53 +0200

> I assume this can be determinded from PSR.

From arch/sparc/kernel/cpu.c:

psr IMPL 0xf with psr VERS of 3
