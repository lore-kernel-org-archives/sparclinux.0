From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 22 Jun 2016 21:07:38 +0000
Subject: Re: Please upgrade your machines to sparc64
Message-Id: <025e2adb-47cc-60f1-f0f9-66d43aa8e7e7@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
In-Reply-To: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 06/22/2016 10:54 PM, chase rayfield wrote:
> Also, who seriously runs Firefox on a T4 server or a LEON4 system or
> vintage sun4 gear like I have?

I didn't claim that you should be running Firefox on a T4 server. I was
giving an example of something which needs more than 4 GiB per process
when *linking*, not running it.

Please don't turn this into "Back in the days" flamefest, these discussions
are always stupid. We are doing software engineering and that is subject
to changes because the requirements on the hard- and software are changing
and increasing.

I am coming from a physics background and I used to do number crunching
on machines with 2 TiB of memory (SGI UV-1000). When you are doing
computational physics, 4 GiB are nothing. I have seen single processes
consume 700 GiB which were doing complex matrix calculations.

> sparc64 kernel + 32bit userland will probably never go away it's what
> most people should be running. So, you'll just end up loosing userbase
> further and inevitably dropping the Debian Sparc port.

Sorry, but this is just laughable. Are you seriously saying that someone
is buying a $40k SPARC-T7 server and then start running a self-compiled
32-bit distribution on that? Those machines can be configured with up to 8 TiB
of memory per machine [1]. No one is going to pay so much money and then
not use the capabilities it has.

sparc64 is what Oracle is currently pouring resources into and what
companies who are willing to pay several grand for a new SPARC server
are going to run.

Do you really think that companies are investing into the SPARC port
because they are targeting hobbyists that want to run SPARC Linux
on museum hardware?

Adrian

> [1] http://www.oracle.com/technetwork/server-storage/sun-sparc-enterprise/documentation/sparc-t7-m7-server-architecture-2702877.pdf

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
