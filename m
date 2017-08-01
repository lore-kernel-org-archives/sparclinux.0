From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue, 01 Aug 2017 19:22:27 +0000
Subject: Re: [PATCH] sunhme: fix up GREG_STAT and GREG_IMASK register offsets
Message-Id: <146814bb-31ad-17af-9edc-3eb5d01777ba@ilande.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <1501172760-26293-1-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1501172760-26293-1-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 01/08/17 00:23, David Miller wrote:

> From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Date: Thu, 27 Jul 2017 17:26:00 +0100
> 
>> Update the values to match those from the STP2002QFP documentation.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> Applied to the networking GIT tree, you should have posted this to
> netdev@vger.kernel.org not (just) the sparc list.

Ah sorry my bad, noted for future reference. Thanks a lot for queuing
the patch, it will be interesting to see what happens when someone tries
it on real hardware...


ATB,

Mark.
