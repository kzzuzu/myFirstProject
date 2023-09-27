package plants.filter;

import java.io.IOException;

import javax.servlet.DispatcherType;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;

/**
 * Servlet Filter implementation class PerformanceFilter
 */
@WebFilter(urlPatterns = { "*.jsp", "*.do" }) // , dispatcherTypes = {DispatcherType.REQUEST, DispatcherType.ERROR}
public class PerformanceFilter extends HttpFilter implements Filter {
	private FilterConfig config;

	/**
	 * @see HttpFilter#HttpFilter()
	 */
	public PerformanceFilter() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		long begin = System.currentTimeMillis();

		chain.doFilter(request, response);

		long end = System.currentTimeMillis();

		String logMessage = ((HttpServletRequest) request).getRequestURL() + ": " + (end - begin) + " ms";

		config.getServletContext().log(logMessage.toString());
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		this.config = fConfig;
	}

}
