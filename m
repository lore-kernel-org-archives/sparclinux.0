From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 22 Jul 2017 09:25:35 +0000
Subject: Re: [PATCH 1/3] sparc64: recognize and support sparc M8 cpu type
Message-Id: <20170722092535.GA7248@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1500536437-14589-1-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1500536437-14589-1-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Jul 22, 2017 at 02:26:25PM +0530, Allen wrote:
> Sam/David,
> >
> >It is way better than the hardcoded values.
> >If the vales have any sort of name in the sparc specs
> >the values shall be prefixed with this.
> >Otherwise something like
> >CPU_ID_xxx
> >
> >And maybe add an intro comment like this:
> >/* following CPU_ID_xxx constants are used to identify the
> >  * CPU type in the setup phase (see xxx.S)
> >*/
> >
> 
> Here's a quick diff. Let me know if this looks good to you guys.
> I'll send out the patch. I have tested this on a T4.
Acked-by: Sam Ravnborg <sam@ravnborg.org>

