From: Sam Ravnborg <sam@mars.domain.invalid>
Date: Fri, 04 Mar 2005 22:16:33 +0000
Subject: Re: [PATCH 2.6] Silence missing CONFIG_ symbol noise
Message-Id: <20050304221633.GA15725@mars.domain.invalid>
List-Id: <sparclinux.vger.kernel.org>
References: <1109914288.17038.64.camel@localhost.localdomain>
In-Reply-To: <1109914288.17038.64.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Mar 03, 2005 at 11:31:27PM -0600, Tom 'spot' Callaway wrote:
> 
> The end result is that the undefined CONFIG_ symbol errors are not
> thrown when the config utilities are run. The errors are not fatal, but
> they do cause confusion when users are building kernels for
> sparc/sparc64.
Another approch would be to just skip the warnings when reading in a
defconfig file. I've never seem them really used.

	Sam
