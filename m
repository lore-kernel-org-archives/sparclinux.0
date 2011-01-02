From: Julian Calaby <julian.calaby@gmail.com>
Date: Sun, 02 Jan 2011 00:46:27 +0000
Subject: Re: [PATCH 9/9] sparc: unify strip command in boot/Makefile
Message-Id: <AANLkTikHUM4Pn5mffWgb79eCiZmKQu-GNQKNwUmKi8k3@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1293915632-4596-9-git-send-email-sam@ravnborg.org>
In-Reply-To: <1293915632-4596-9-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Jan 2, 2011 at 08:00, Sam Ravnborg <sam@ravnborg.org> wrote:
> Include an additional "Kernel is ready" print for zImage

I was going to ask if this line is necessary, but a quick peek through
the other architectures reveals that most of them print something
along these lines, notable exceptions being "xtensa", "s390",
"powerpc", "mips", "frv" and "blackfin". Blackfin doesn't count
because it seems to be producing files to be fed into some external
utility before sticking it on a board.

Thanks,

-- 

Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
