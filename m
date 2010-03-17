From: David Miller <davem@davemloft.net>
Date: Wed, 17 Mar 2010 07:05:57 +0000
Subject: Re: Serial console issue with 2.6.32
Message-Id: <20100317.000557.15934001.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201003151809.27436.elendil@planet.nl>
In-Reply-To: <201003151809.27436.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frans Pop <elendil@planet.nl>
Date: Mon, 15 Mar 2010 18:09:27 +0100

> With a daily built version of the installer (based on 2.6.32.9) the first 
> two methods work, but the third doesn't.
> At the point where output should start appearing on my remote system, 
> minicom shows ttyS0 going offline.

I changed the behavior of SUNSAB serial consoles in 2.6.32
and later, see:

commit 4e68e188411ea98e40309700cf0c89ad4469ac1d
Author: David S. Miller <davem@davemloft.net>
Date:   Tue Nov 24 13:56:39 2009 -0800

    sunsab: Do not set sunsab_reg.cons right before registering minors.
    
    Other Sun serial drivers do not do this, and if we keep it this way
    it ends up registering all serial devices as consoles rather than
    just the one which we explicitly register via sunserial_console_match()
    which uses add_preferred_console().
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

This makes it consistent with the way all the other Sun serial
console drivers were behaving.

Looking more at what you're trying to do, I think you really need to
set the output-device and input-device firmware variables properly.

The kernel tries very hard to use whatever the firmware specified
as the output-device as the console.  I couldn't find an easy way
get the behaviour you were after, yet at the same time get the
multiple-serial-devices-only-one-is-console case right all the
time.

