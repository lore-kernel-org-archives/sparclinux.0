From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 17 Jun 2008 12:35:15 +0000
Subject: Re: [RFC] unify exported sparc header files?
Message-Id: <20080617123515.GB10598@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080601072044.GA16220@uranus.ravnborg.org>
In-Reply-To: <20080601072044.GA16220@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Adrian.

> What about my patches that merge openprom_32.h and openprom_64.h into 
> openprom.h?
Looked good.
But I just stopped where I reached now as I ran out of time
and wanted to get what I had upstream.

Where I wrote (join them) I was obviously planning to
find the parts that are equal and your patch-set would be a great help here.
Even better if you could redo it on too
of what is in sparc-next now (so we avoid the _32.h, _64.h step).

I would be glad if you could take a look at the few remaining .h files
because avoinding the _32.h and _64.h files is a plus.

> I'd assume the goal is to merge the complete sparc64 architecture into 
> sparc?
David - do you have such plans?

I will most likely not be able to contribute until late this year
as I soon will be on leave from the kernel businness as I am building
a new house and moving and stuff (announcement to kbuild
in a few weeks).
But then it could be fun (but need to get my sparc64 box operational then).

	Sam
