From: William Lee Irwin III <wli@holomorphy.com>
Date: Sun, 22 Feb 2004 09:57:55 +0000
Subject: Re: oops in sched_init() on E3000
Message-Id: <20040222095755.GJ703@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040222043448.GG703@holomorphy.com>
In-Reply-To: <20040222043448.GG703@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

n Sat, Feb 21, 2004 at 11:25:33PM -0800, David S. Miller wrote:
>> So, Will, did you test out the test kernel image I emailed to you the
>> other day or did your spam filter eat it?

On Sun, Feb 22, 2004 at 01:11:50AM -0800, William Lee Irwin III wrote:
> Unfortunately I never saw a test kernel image, so the spamfiltering bit
> looks likely.

Make that "certain":

# zgrep -n davem /var/log/exim/mainlog.* |grep rejected
/var/log/exim/mainlog.2.gz:1757:2004-02-18 16:14:59 rejected MAIL FROM:<davem@redhat.com> H=mx1.redhat.com [66.187.233.31]: message too large: size 23034 max48576

I turned down the max message size when I heard about spam attempting
to taint ppl with bloze source code going around. =(


-- wli
