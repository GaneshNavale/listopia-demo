describe('Listopia Home Page', () => {
  it('should load homepage and show hero section', () => {
    cy.visit('http://localhost:3000/');

    // ✅ Check title
    cy.title().should('include', 'Listopia');

    // ✅ Check hero heading
    cy.contains('Where Lists Come to').should('be.visible');

    // ✅ Check sign up and sign in buttons
    cy.contains('Get Started Free')
      .should('have.attr', 'href', '/sign_up')
      .and('be.visible');

    cy.contains('Sign In')
      .should('have.attr', 'href', '/sign_in')
      .and('be.visible');
  });

  it('navigates to Sign Up page', () => {
    cy.visit('http://localhost:3000/');
    cy.contains('Get Started Free').click();
    cy.url().should('include', '/sign_up');
  });

  it('navigates to Sign In page', () => {
    cy.visit('http://localhost:3000/');
    cy.contains('Sign In').click();
    cy.url().should('include', '/sign_in');
  });
});
