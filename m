From: Ben Collins <bcollins@debian.org>
Date: Thu, 19 Feb 2004 00:35:30 +0000
Subject: Re: another Ultra2 SMP crash
Message-Id: <20040219003530.GD456@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.58.0402181628060.21617@redfish.gatech.edu>
In-Reply-To: <Pine.GSO.4.58.0402181628060.21617@redfish.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Feb 18, 2004 at 04:29:30PM -0500, Chris Ricker wrote:
> This is with 2.6.3-rc2, compiled SMP
> 
> All I had on the serial console was

Do you have preempt enabled? I've already noticed from other people that
it is causing problems (one showed as a race conditition with autoload
of modules).

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
