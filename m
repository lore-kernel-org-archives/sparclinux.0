From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 24 Mar 2005 05:46:35 +0000
Subject: Re: sparc32: module with unresolved symbol causes oops in
Message-Id: <20050323214635.5ffa08c5.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0503231549330.5000@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0503231549330.5000@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 23 Mar 2005 22:41:59 +0100
Sam Ravnborg <sam@ravnborg.org> wrote:

> I stopped when the build told me:

Someone looked into this and discussed it on linux-kernel not
2 weeks ago, it was an involved thread and the result was
"mark as non-modular on sparc and other platforms with similar
 issued".
