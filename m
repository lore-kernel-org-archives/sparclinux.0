From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Sun, 27 May 2007 07:17:17 +0000
Subject: Re: BUG in kcryptd?
Message-Id: <Pine.LNX.4.61.0705270916370.7344@yvahk01.tjqt.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <464B1F2B.3030009@xs4all.nl> <Pine.LNX.4.61.0705161751020.9570@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0705161751020.9570@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Udo van den Heuvel <udovdh@xs4all.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org


On May 16 2007 17:52, Jan Engelhardt wrote:
>On May 16 2007 17:11, Udo van den Heuvel wrote:
>>
>>While opening an encrypted partition and trying to fsck it:
>
>Yeah, somewhere is a bug in it, I also get an oops with
>kcryptd in 2.6.20 on sparc64 after a few minutes (though,
>it's a NULL dereference there).

...which also seems to be gone for me with some 2.6.21.



	Jan
-- 
