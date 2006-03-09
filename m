From: Ben Collins <bcollins@ubuntu.com>
Date: Thu, 09 Mar 2006 22:54:07 +0000
Subject: Re: silo-1.4.11
Message-Id: <1141944847.4406.10.camel@grayson>
List-Id: <sparclinux.vger.kernel.org>
References: <4410A7F7.9090405@gmail.com>
In-Reply-To: <4410A7F7.9090405@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 2006-03-09 at 17:11 -0500, Joe Ciccone wrote:
> One update to this monster of a patch because with the version change in
> Rules.make it didn't apply cleanly.
> 
> http://www.crazyeyesoft.com/silo-1.4.11-fixes-1.patch

I can't really take this patch into silo directly. Can you separate the
parts that patch up the current code from the part where you basically
import all of libext2fs and add the emul_32 headers?

I can take the build changes, but the rest of it is just creating
headache for me because it requires syncing to external source.

-- 
Ubuntu     - http://www.ubuntu.com/
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
SwissDisk  - http://www.swissdisk.com/

