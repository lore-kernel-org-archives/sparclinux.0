From: David Miller <davem@davemloft.net>
Date: Tue, 30 Oct 2007 02:49:01 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <20071029.194901.183763881.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bernd Zeimetz <bernd@bzed.de>
Date: Tue, 30 Oct 2007 03:43:32 +0100

> I just grepped trough the source of aptitude, there's only one fork, but
> that one should not be executed if aptitude has been started as root.
> If it is of any use for you I can figure out which piece of code
> resulted in the call to clone, or figure out which piece of code results
>  results in the use of futexes there.

That's not necessary, thanks.

The futex() calls are definitely from libnss-db.
