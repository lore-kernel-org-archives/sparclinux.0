From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 19 Apr 2011 16:04:01 +0000
Subject: Re: [PATCH 3/3] sparc32: genirq support
Message-Id: <4DADB271.80001@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1303161944-13611-3-git-send-email-sam@ravnborg.org>
In-Reply-To: <1303161944-13611-3-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sam Ravnborg wrote:

>The conversion of sparc32 to genirq is based on original work done
>by David S. Miller.
>Daniel Hellstrom has helped in the conversion and implemented
>the shutdowm functionality.
>Marcel van Nies <morcles@gmail.com> has tested this on Sparc Station 20
>
>Test status:
>sun4c      - not tested
>sun4m,pci  - not tested
>sun4m,sbus - tested (Sparc Classic, Sparc Station 5, Sparc Station 20)
>sun4d      - not tested
>leon       - tested on various combinations of leon boards,
>             including SMP variants
>  
>
Hello Sam,

I have tested this version of your patch on a couple of LEONs, and it 
works fine.

Thanks for a great job,

Daniel
