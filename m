From: David Miller <davem@davemloft.net>
Date: Tue, 03 Jun 2008 20:13:43 +0000
Subject: Re: [BUG] 2.6.26-rc1 broke X on SPARC Ultra5
Message-Id: <20080603.131343.86564905.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080603.062253.17158135.davem@davemloft.net>
	<18501.39659.952880.727014@alkaid.it.uu.se>
	<a5f334790806031259nc872dcekd00315d3e5bea048@mail.gmail.com>
In-Reply-To: <a5f334790806031259nc872dcekd00315d3e5bea048@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raimoschmidt@gmail.com
Cc: mikpe@it.uu.se, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: "Raimo Schmidt" <raimoschmidt@gmail.com>
Date: Tue, 3 Jun 2008 23:59:49 +0400

> Hello. I've the same problem runnin' X.org 6 using kernel 2.6.25.4 on PC.
> After few seconds of black screen it writes that X.org died

The patch discussed here is sparc64 specific so won't in any way
help your case on a PC, sorry.
