From: David Miller <davem@davemloft.net>
Date: Fri, 02 Jun 2017 14:22:59 +0000
Subject: Re: sparc gcc 7.1 compile issue
Message-Id: <20170602.102259.363059784928463769.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170531193431.GA26922@waldemar-brodkorb.de>
        <20170531.171008.528800003662477033.davem@davemloft.net>
        <20170602091717.GA7452@physik.fu-berlin.de>
In-Reply-To: <20170602091717.GA7452@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: glaubitz@physik.fu-berlin.de
Cc: wbx@openadk.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 2 Jun 2017 11:17:18 +0200

> On Wed, May 31, 2017 at 05:10:08PM -0400, David Miller wrote:
>> A fix for this is in Linus's tree and was submitted to -stable last
>> night:
> 
> What remains to be fixed though is that the gcc-7 testsuite
> *reproducibly* kills the kernel on sparc64 when building with more than
> around 20 jobs:

Well, I already have a release gcc bug to fix so pretty much I have no
time to look into bugs in unreleased versions of gcc sorry.
