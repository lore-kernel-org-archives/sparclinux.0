From: Sunil Amitkumar Janki <devel.sjanki@gmail.com>
Date: Mon, 01 Oct 2007 10:24:20 +0000
Subject: Re: SPARC64 2.6.23-rc8 binfmt_aout32 error
Message-Id: <4700CAD4.4010902@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <470034EA.4060906@gmail.com>
In-Reply-To: <470034EA.4060906@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> Turn off BINFMT_AOUT32 is a quick way to get a successful build,
> I wonder if considered that :-)
>
> I've never seen this build failure before, but will try to
> reproduce with some gcc-4.2 compiler setups I have here.
>   
I haven't got much more than a tool chain yet so then
I would have to build a GCC 4.1.2 compiler. Now with
your information I should and probably will do so.

I already tried to disable all other executable formats
but that didn't help much either. Thanks for the patch,
I will try building with it and report my findings.

Sunil

