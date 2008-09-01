From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 01 Sep 2008 13:57:29 +0000
Subject: Re: tty compile warnings
Message-Id: <20080901145729.6915f322@lxorguk.ukuu.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <48BBEDB2.3080207@earthlink.net>
In-Reply-To: <48BBEDB2.3080207@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 01 Sep 2008 09:27:14 -0400
Robert Reif <reif@earthlink.net> wrote:

> I have been getting these compile warnings on sparc32 for a few weeks now:

gcc is complaining about some nasty hacks the sparc32 tree does with
termios.

        cc_t c_cc[NCCS];                /* control characters */
#ifdef __KERNEL__
#define SIZEOF_USER_TERMIOS sizeof (struct termios) - (2*sizeof (cc_t))
        cc_t _x_cc[2];                  /* We need them to hold
vmin/vtime */ #endif


struct ktermios {
        tcflag_t c_iflag;               /* input mode flags */
        tcflag_t c_oflag;               /* output mode flags */
        tcflag_t c_cflag;               /* control mode flags */
        tcflag_t c_lflag;               /* local mode flags */
        cc_t c_line;                    /* line discipline */  
        cc_t c_cc[NCCS];                /* control characters */
        cc_t _x_cc[2];                  /* We need them to hold
vmin/vtime */ speed_t c_ispeed;               /* input speed */
        speed_t c_ospeed;               /* output speed */
};



You could try removing _x_cc[2] and changing [NCCS] to [NCCS+2] which
might work depending upon the alignment you get.

