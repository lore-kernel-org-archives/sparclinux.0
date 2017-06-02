From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 02 Jun 2017 16:33:45 +0000
Subject: Re: sparc gcc 7.1 compile issue
Message-Id: <1f8e2488-d051-7688-2d40-089f4acab6ce@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20170531193431.GA26922@waldemar-brodkorb.de>
 <20170531.171008.528800003662477033.davem@davemloft.net>
 <20170602091717.GA7452@physik.fu-berlin.de>
 <20170602.102259.363059784928463769.davem@davemloft.net>
In-Reply-To: <20170602.102259.363059784928463769.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: wbx@openadk.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On 06/02/2017 04:22 PM, David Miller wrote:
>> What remains to be fixed though is that the gcc-7 testsuite
>> *reproducibly* kills the kernel on sparc64 when building with more than
>> around 20 jobs:
> 
> Well, I already have a release gcc bug to fix so pretty much I have no
> time to look into bugs in unreleased versions of gcc sorry.

Isn't a bug in the kernel if an application is able to crash to the point
that the machine has to be hard-rebooted?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
