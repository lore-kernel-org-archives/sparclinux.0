From: Weeve <weeve@stargazer.weeve.org>
Date: Sun, 30 Oct 2005 02:48:35 +0000
Subject: Re: possible cg6 fix for pixels repeating at display edge or fading
Message-Id: <20051029204835.200ed80c@enterprise.weeve.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4363EE58.1090508@mc.net>
In-Reply-To: <4363EE58.1090508@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 29 Oct 2005 16:49:12 -0500
Bob Breuer <breuerr@mc.net> wrote:

> Has anyone else using a cg6 seen the color banding or fading and
> pixels on the right side being repeated off to the edges of the
> monitor?

I'm seeing it as well with a cg6 (501-1672( in an Ultra 1.

> I think I've found the cause of the problem.  Contrary to the comment,
> changing the bt->control register affects something other than the
> cursor.  Also, it looks like cg6_bt_init() already sets up the DAC and
> this chunk of the code may be redundant.
> 
> The following patch seems to work for me on a TGX+.  If you are seeing
> problems, can you give this a try and report if it works or not?

Your patch works for me.  The odd coloration of text and pixels on the
edges of the screen (was seeing on both left and right here with
colorized init scripts) have gone away.  Display looks as I'd expect.

Cheers,
-- 
Jason Wever
Gentoo/Sparc Team Co-Lead
