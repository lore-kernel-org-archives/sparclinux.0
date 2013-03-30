From: David Miller <davem@davemloft.net>
Date: Sat, 30 Mar 2013 23:17:37 +0000
Subject: Re: [PATCH 4/5] sparc: use asm-generic version of types.h
Message-Id: <20130330.191737.2076080257143982176.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1364679866-29982-4-git-send-email-sam@ravnborg.org>
In-Reply-To: <1364679866-29982-4-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 30 Mar 2013 23:07:33 +0100

> On Sat, Mar 30, 2013 at 06:02:47PM -0400, David Miller wrote:
>> From: Sam Ravnborg <sam@ravnborg.org>
>> Date: Sat, 30 Mar 2013 22:44:25 +0100
>> 
>> > We failed to include the header file that define __u16 because __sparc__
>> > was not defined.
>> 
>> Is this another problem with your cross compiler?
>> 
>> __sparc__ should always be defined, it's a CPP pre-define.
> 
> Maybe..
> 
> But Fengguang Wu see the same issue in his 0-day
> testing.
> But maybe we have both gcc issues.

I'm not fundamentally against these changes, if there would be
a good reason for them.

But it seems to me that these cross compilers are terminally broken,
you cannot seriously even expect them to be able to compiler userland
successfully at all because __linux__ and __sparc__ must be CPP
predefined for userspace to compiler properly.
